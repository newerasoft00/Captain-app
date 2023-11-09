import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../Model/Roshn League/game_weak.dart';
import '../../../Model/ads/user_information.dart';
import '../../../Model/teams/h2h_model.dart';

class RoundPintController extends GetxController {
  final matches = <Head2Head>[].obs;
  RxList<RoshnMatch> roshnFixtures = <RoshnMatch>[].obs;
  final CollectionReference userBetCollection =
      FirebaseFirestore.instance.collection("User'sBet");
  final firestoreInstance = FirebaseFirestore.instance;
  RxList<User> user = RxList<User>();
  User? userinformation;
  RxList<String> documentNames = RxList<String>();
  RxList<RoshnMatch> matchesData =
      <RoshnMatch>[].obs; // List to store fetched data
  RxList<Map<String, String>> bets = RxList<Map<String, String>>();
  RxInt betsLength = 0.obs;
  List<Map<String, dynamic>> filteredBets = [];

  Future<void> fetchDocumentNames() async {
    try {
      final querySnapshot = await userBetCollection.get();
      documentNames.assignAll(querySnapshot.docs.map((doc) => doc.id));
      print(documentNames);
      for (var i = 0; i < documentNames.length; i++) {
        print(documentNames[i]);
        print(documentNames[0]);
        await fetchMatchesData(documentNames[i]);
        await fetchBets(documentNames[i]);
        print('get it ${bets[i]}');
        int homeScore =
            int.parse(matchesData[i].eventFinalResult.split('-')[0].trim());
        int awayScore =
            int.parse(matchesData[i].eventFinalResult.split('-')[1].trim());
        final winTeam = (homeScore > awayScore)
            ? matchesData[i].eventHomeTeam
            : (homeScore == awayScore)
                ? 'Drawing'
                : matchesData[i].eventAwayTeam;
        filteredBets = bets.where((bet) {
          return (bet['winTeam'] == winTeam) &&
              (matchesData[i].eventFinalResult ==
                  '${bet['winScore']} - ${bet['loseScore']}');
        }).toList();
        print('filtered  ${filteredBets.toList()}');
        for (var bet in filteredBets) {
          String roundID =
              matchesData[i].leagueRound; // Replace with the actual round ID
          String matchID = matchesData[i].eventKey.toString();
          String userID = bet['userID'];
          // Call the saveBetToFirebase method for each user
          saveBetToFirebase(roundID, matchID, userID);
          print('save it ');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> fetchMatchesData(String matchID) async {
    final response = await http.get(Uri.parse(
        'https://apiv2.allsportsapi.com/football/?met=Fixtures&matchId=$matchID&APIkey=256f30963c54aded80f166f02faa41b481d6d5c072d4649db09500ad8ac071fc'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final resultData = jsonData['result'] as List<dynamic>;
      matchesData.addAll(resultData
          .map((fixtureJson) => RoshnMatch.fromJson(fixtureJson))
          .toList());
    } else {
      if (kDebugMode) {
        print('Failed to load data for match $matchID');
      }
    }
  }

  Future<void> fetchH2H(String t1, String t2) async {
    String url =
        'https://apiv2.allsportsapi.com/football/?met=H2H&APIkey=256f30963c54aded80f166f02faa41b481d6d5c072d4649db09500ad8ac071fc&firstTeamId=$t1&secondTeamId=$t2';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final matchesData = jsonData['result']['H2H'] as List;

      final matchesList = matchesData.map((match) {
        return Head2Head.fromJson(match);
      }).toList();

      matches.assignAll(matchesList);
    } else {
      if (kDebugMode) {
        print('Failed to load data from the API');
      }
    }
  }

  void saveBetToFirebase(String roundID, String matchID, String userID) async {
    print('saveBetToFirebase ****** ');
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get the reference to the "Winner" collection
    CollectionReference winnerCollection = firestore.collection('Winner');

    // Create a reference to the document using roundID
    DocumentReference roundDocument = winnerCollection.doc(roundID);
    print(roundDocument);
    // Get the existing data (if any) from the document
    var existingData = await roundDocument.get();

    // Check if the document already exists or not
    if (existingData.exists) {
      print('Check if the document already exists or not');
      // If the document exists, add the userID to the array
      await roundDocument.update({
        matchID: FieldValue.arrayUnion([userID])
      });
      getUserAppearanceCounts();
      saveUserAppearanceCountsToFirestore(userID);
    } else {
      print(
          'If the document does not exist, create it with the userID in the array');
      // If the document does not exist, create it with the userID in the array
      await roundDocument.set({
        matchID: [userID]
      });
      saveUserAppearanceCountsToFirestore(userID);
    }
    // updateOrSetNumericValue(userID, 1);
  }

  Future<void> fetchBets(String matchID) async {
    try {
      final querySnapshot = await userBetCollection.doc(matchID).get();
      if (querySnapshot.exists) {
        final data = querySnapshot.data() as Map<String, dynamic>;
        // Check if the array field exists
        if (data.containsKey('bets')) {
          final betArray = data['bets'] as List<dynamic>;
          // Convert betArray to List<Map<String, String>>
          final betsList = betArray.map((bet) {
            final loseScore = bet['loseScore'] as String?;
            final userID = bet['userID'] as String?;
            final winScore = bet['winScore'] as String?;
            final winTeam = bet['winTeam'] as String?;

            // Check for null values before assigning to the map
            return {
              'loseScore': loseScore ?? '',
              'userID': userID ?? '',
              'winScore': winScore ?? '',
              'winTeam': winTeam ?? '',
            };
          }).toList();

          bets.assignAll(betsList);

          // Get the length of the betsList
          betsLength.value = betsList.length;
          throw Exception('Length of the bets array: $betsLength');
        } else {}
      }
    } catch (e) {
      // throw Exception('Error fetching bets: $e');
    }
  }

  Future<void> saveUserAppearanceCountsToFirestore(String userID) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference winnerCollection = firestore.collection('Winner');

    // Query all documents in the "Winner" collection
    QuerySnapshot querySnapshot = await winnerCollection.get();

    // Initialize a map to store the user appearance counts
    Map<String, int> userAppearanceCounts = {};

    // Iterate through the documents
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      // Get the data from the document
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Iterate through the fields in the document
      data.forEach((field, value) {
        if (value is List) {
          for (var userID in value) {
            if (userAppearanceCounts.containsKey(userID)) {
              print('contain user ID ______________ ');
              // If the user ID is already in the map, increment the count
              userAppearanceCounts[userID]! + 1;
              print(
                  'see it userAppearanceCounts ${userAppearanceCounts[userID]! + 1}');
            } else {
              print('not ***** contain user ID ______________ ');
              // If the user ID is not in the map, add it with a count of 1
              userAppearanceCounts[userID] = 1;
            }
          }
        }
      });
    }
    print('now save it in user info ');
    // Now, save the user appearance counts to the 'User Information' collection
    userAppearanceCounts.forEach((userID, count) async {
      print('begin saving it ****************** ');
      final docRef = firestore.collection('User Information').doc(userID);
      await docRef.update({'total_bet_point': count});
    });
  }

  Future<Map<String, int>> getUserAppearanceCounts() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference winnerCollection = firestore.collection('Winner');

    // Query all documents in the "Winner" collection
    QuerySnapshot querySnapshot = await winnerCollection.get();

    // Initialize a map to store the user appearance counts
    Map<String, int> userAppearanceCounts = {};

    // Iterate through the documents
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      // Get the data from the document
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Iterate through the fields in the document
      data.forEach((field, value) {
        if (value is List) {
          // If the field value is a list, iterate through it
          for (var userID in value) {
            if (userAppearanceCounts.containsKey(userID)) {
              // If the user ID is already in the map, increment the count
              userAppearanceCounts[userID]! + 1;
            } else {
              // If the user ID is not in the map, add it with a count of 1
              userAppearanceCounts[userID] = 1;
            }
          }
        }
      });
    }
    return userAppearanceCounts;
  }

  @override
  void onInit() async {
    print(
        'init --------------------------------------------------------------');
    super.onInit();
    await fetchDocumentNames();
  }
}

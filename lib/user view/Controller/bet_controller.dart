import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Model/Roshn%20League/game_weak.dart';
import 'package:sportsbet/user%20view/Services/bet/new_bet_service.dart';
import 'package:sportsbet/user%20view/Services/bet/save_user_bet.dart';

import '../../Core/helper/shared_preference/shared_preference.dart';
import '../Services/bet/get_user_bet.dart';
import '../View/Screens/Roshn Matches/match_details_page.dart';

class BetOptionController extends GetxController {
  final betOptions = [].obs;
  var bets = <Map<String, dynamic>>[].obs;
  final NewBetService newBetService = NewBetService();
  final GetUserBetService getUserBetSer = GetUserBetService();
  final SaveUserBet saveUserBet = SaveUserBet();
  RxBool checkoptions = false.obs;
  final List<RxBool> rxBoolList = [];
  final RxString selectedM = ''.obs;
  RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  RxBool userbetted = false.obs;
  RxBool homebetted = false.obs;
  RxBool awaybetted = false.obs;
  RxBool drawbetted = false.obs;
  RxString userChoice = ''.obs;
  RxString userChoicescore1 = ''.obs;
  RxString userChoicescore2 = ''.obs;
  RxInt usersChoseHomeTeam = 0.obs;
  RxInt usersChoseAwayTeam = 0.obs;
  RxInt usersChoseDrawing = 0.obs;
  RxDouble homeTeamPercentage = 0.0.obs;
  RxDouble awayTeamPercentage = 0.0.obs;
  RxDouble drawingPercentage = 0.0.obs;

  @override
  void onClose() {
    _isLoading.value = false;
    rxBoolList.clear();
    super.onClose();
  }

  @override
  void onInit() async {
    // Fetch data from Firestore when the controller is initialized
    super.onInit();
    fetchBetOptions(selectedM.value);
  }

  changeMatch(String value) {
    selectedM.value = value;
    fetchBetOptions(value);
    generateBool();
  }

  generateBool() {
    for (int i = 0; i < betOptions.length; i++) {
      final rxBool = RxBool(false);
      rxBoolList.add(rxBool);
    }
  }

  Future<void> saveUserBetinFireStore(
    String userId,
    String matchId,
    String teams,
    String roundId,
    String userBet,
  ) async {
    try {
      final userDocRef = FirebaseFirestore.instance
          .collection('User Information')
          .doc(userId)
          .collection('round_point')
          .doc(roundId);

      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        final userData = userDocSnapshot.data() as Map<String, dynamic>;
        final betHistory = userData['round_bet'] as List<dynamic>?;

        if (betHistory == null) {
          // If 'betHistory' is null or missing, create an empty list
          userData['round_bet'] = [];
        }

        // Check if the user already has a bet entry with the same match_Id
        final existingBetIndex = betHistory!.indexWhere((betEntry) {
          final betData = betEntry as Map<String, dynamic>;
          return betData['match_id'] == matchId;
        });

        if (existingBetIndex != -1) {
          // If the user already has a bet for the same match_Id, update it
          final updatedBetEntry = {
            'match_id': matchId,
            'teams': teams,
            'match_score': userBet,
          };

          // Update the existing bet entry in the 'round_bet' list
          userData['round_bet'][existingBetIndex] = updatedBetEntry;
        } else {
          // If the user does not have an existing bet for the same match_Id, add a new bet entry
          final betEntry = {
            'match_id': matchId,
            'teams': teams,
            'match_score': userBet,
          };

          // Add the new bet entry to the 'round_bet' list
          userData['round_bet'].add(betEntry);
        }

        // Update the user document with the modified 'round_bet' list
        await userDocRef.set(
          userData,
          SetOptions(merge: true), // Merge with existing data
        );
      } else {
        // If the user document doesn't exist, create it and add 'round_bet' list
        final betEntry = {
          'match_id': matchId,
          'teams': teams,
          'match_score': userBet,
        };

        final userData = {
          'round_bet': [betEntry],
        };

        await userDocRef.set(userData);
      }
    } catch (e) {
      // Handle error, show error message, or retry logic here.
    }
  }

  void fetchBetOptions(String match) async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('Roshn bet option ')
          .doc(match)
          .get();

      if (documentSnapshot.exists) {
        // Document exists, you can access its data
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final betOptionArray = data['betoption'] as List<dynamic>;

        // Update the observable list with Firestore data
        betOptions.assignAll(betOptionArray);
      }
    } catch (e) {
      _isLoading = false.obs;
    }
  }

  Future<void> addBetToFirestore(
      String roundID,
      String userId,
      String chosenbet,
      String matchKey,
      String winScore,
      String loseScore) async {
    try {
      await newBetService.addDataToFirestore(
          roundID, userId, chosenbet, matchKey, winScore, loseScore);
    } catch (e) {
      // Handle error, show error message, or retry logic here.
    }
  }

  Future<bool> doesCheckBetContainUser(String userId, String homeTeam) async {
    try {
      final DocumentReference checkBetDocRef =
          FirebaseFirestore.instance.collection("checkBet").doc(homeTeam);
      final DocumentSnapshot checkBetDoc = await checkBetDocRef.get();

      if (checkBetDoc.exists) {
        final Map<String, dynamic> data =
            checkBetDoc.data() as Map<String, dynamic>;
        if (data.containsKey(userId)) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // print('Error checking if "checkBet" contains user: $e');
      return false;
    }
  }

  String? validateDrawBet1(String? value) {
    final intParsedValue = int.parse(value!);
    final intUserChoice2 = int.parse(userChoicescore2.value);
    final intUserChoice1 = int.parse(userChoicescore1.value);

    if (drawbetted.value == true) {
      if (intParsedValue != intUserChoice2) {
        return '!'; // Return your error message or icon
      }

      if (intUserChoice2 != intUserChoice1) {
        return '!'; // Return your error message or icon
      }
    }
    return null;
  }

  String? validateDrawBet2(String? value) {
    final intParsedValue = int.parse(value!);
    final intUserChoice2 = int.parse(userChoicescore2.value);
    final intUserChoice1 = int.parse(userChoicescore1.value);

    if (drawbetted.value == true) {
      if (intParsedValue != intUserChoice1) {
        return '!'; // Return your error message or icon
      }

      if (intUserChoice2 != intUserChoice1) {
        return '!'; // Return your error message or icon
      }
    }
    return null;
  }

  String? validateHomeBet(String? value) {
    if (homebetted.value == true) {
      try {
        final intParsedValue = int.parse(value!);
        final intUserChoice = int.parse(userChoicescore2.value);
        if ((intParsedValue <= intUserChoice)) {
          return '!'; // Return your error mess
        }
      } catch (e) {
        // Handle invalid input that can't be parsed as an integer
        return '!'; // Return your error message or icon
      }
      return null; // Return null if validation passes
    }
    return null;
  }

  String? validateAwayBet(String? value) {
    if (awaybetted.value == true) {
      try {
        final intParsedValue = int.parse(value!);
        final intUserChoice = int.parse(userChoicescore1.value);

        if (intParsedValue <= intUserChoice) {
          return '!'; // Return your error message or icon
        }
      } catch (e) {
        // Handle invalid input that can't be parsed as an integer
        return '!'; // Return your error message or icon
      }
      return null; // Return null if validation passes
    }
    return null;
  }

  selectMatch(RoshnMatch fixture) async {
    betOptions.clear();
    changeMatch(fixture.eventKey.toString());
    fetchBetOptions(fixture.hometeamkey.toString());
    fetchMatchBets(fixture.eventKey.toString(), fixture.eventHomeTeam,
        fixture.eventAwayTeam);
    // await fetchUserBetsForMatch(
    //     fixture.leagueRound,
    //     fixture.eventKey.toString(),
    //     fixture.eventHomeTeam,
    //     fixture.eventAwayTeam);
    // print(fixture.eventKey);
    Get.to(() => MatchDetailsPage(fixture: fixture));
  }

  Future<void> fetchMatchBets(
      String matchID, String homeTeam, String awayTeam) async {
    FirebaseFirestore.instance
        .collection("User'sBet")
        .doc(matchID)
        .snapshots()
        .listen((document) {
      if (document.exists) {
        var betsData =
            (document['bets'] as List<dynamic>).cast<Map<String, dynamic>>();
        resetStatistics();
        int totalUsers = betsData.length;

        for (var bet in betsData) {
          if (bet['winTeam'] == awayTeam) {
            usersChoseAwayTeam.value++;
          } else if (bet['winTeam'] == homeTeam) {
            usersChoseHomeTeam.value++;
          } else if (bet['winTeam'] == 'Drawing') {
            usersChoseDrawing.value++;
          }
        }
        if (totalUsers > 0) {
          awayTeamPercentage.value =
              (usersChoseAwayTeam.value / totalUsers) * 100;
          homeTeamPercentage.value =
              (usersChoseHomeTeam.value / totalUsers) * 100;
          drawingPercentage.value =
              (usersChoseDrawing.value / totalUsers) * 100;
        }
      }
    });
  }

  Future<void> fetchUserBetsForMatch(
      String roundId, String matchKey, String homeTeam, String awayTeam) async {
    try {
      // Use the GetUserBetService to get the user's bet stream
      final userBetService = GetUserBetService();
      final userBetStream = userBetService.getUserBetStream(
          roundId, matchKey, UserPreference.getUserid());

      // Subscribe to the user bet stream
      userBetStream.listen((userBet) {
        // if (userBet != null) {
        //   // Reset statistics
        //   usersChoseHomeTeam.value = 0;
        //   usersChoseAwayTeam.value = 0;
        //   usersChoseDrawing.value = 0;
        //   int totalUsers = usersChoseHomeTeam.value +
        //       usersChoseAwayTeam.value +
        //       usersChoseDrawing.value;
        //   // Calculate statistics based on the user's bet
        //   if (userBet.winTeam == awayTeam) {
        //     usersChoseAwayTeam.value++;
        //     awayTeamPercentage.value =
        //         ((usersChoseAwayTeam.value / totalUsers) * 100);
        //   } else if (userBet.winTeam == homeTeam) {
        //     usersChoseHomeTeam.value++;
        //     homeTeamPercentage.value =
        //         ((homeTeamPercentage.value / totalUsers) * 100);
        //   } else if (userBet.winTeam == 'Drawing') {
        //     usersChoseDrawing.value++;
        //     drawingPercentage.value =
        //         ((usersChoseDrawing.value / totalUsers) * 100);
        //   }
        // }
      });
    } catch (e) {
      //print('Error fetching user bets: $e');
    }
    // You may need to update your totalUsers value if it depends on other data
    update();
  }

  void resetStatistics() {
    usersChoseHomeTeam.value = 0;
    usersChoseAwayTeam.value = 0;
    usersChoseDrawing.value = 0;
    awayTeamPercentage.value = 0.0;
    homeTeamPercentage.value = 0.0;
    drawingPercentage.value = 0.0;
  }
}

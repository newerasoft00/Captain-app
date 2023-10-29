import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Model/bet/round_standing_model.dart';

class OverallBetPointController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Map<String, dynamic>> userCounts = <Map<String, dynamic>>[].obs;
  Map<String, Map<String, int>> result = {};
  Map<String, Map<String, int>> displayResult = {};
  List<RoundStandingsModel> userAppearanceList = [];

  Future<void> retrieveUserAppearanceCounts() async {
    try {
      final QuerySnapshot querySnapshot =
          await firestore.collection('User Information').get();
      userCounts.clear();

      for (final QueryDocumentSnapshot doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final name = data['name'] ?? 'name';
        final uid = data['uid'] ?? ' ';
        final appearanceCount = data['total_bet_point'] ?? 0;
        userCounts.add({
          'uid': uid,
          'userId': name,
          'appearanceCount': appearanceCount,
        });
      }

      // Sort the list in descending order by appearanceCount
      userCounts
          .sort((a, b) => b['appearanceCount'].compareTo(a['appearanceCount']));

      update(); // Notify listeners about the changes
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving user appearance counts: $e');
      }
    }
  }

  Future<Map<String, Map<String, int>>> getUserAppearanceCounts() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference winnerCollection = firestore.collection('Winner');

    // Query all documents in the "Winner" collection
    QuerySnapshot querySnapshot = await winnerCollection.get();

    // Initialize a map to store the result
    Map<String, Map<String, int>> result = {};

    // Iterate through the documents
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      // Get the document ID
      String docId = document.id;

      // Get the data from the document
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Initialize a map to store user appearance counts in this document
      Map<String, int> userAppearanceCounts = {};

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

      // Add the user appearance counts to the result map
      result[docId] = userAppearanceCounts;
    }

    return result;
  }

  Future<List<RoundStandingsModel>> displayUserAppearanceCounts() async {
    Map<String, Map<String, int>> result = await getUserAppearanceCounts();
    userAppearanceList.clear();
    result.forEach((docId, userAppearanceCounts) {
      userAppearanceList.add(RoundStandingsModel(docId, userAppearanceCounts));
    });

    return userAppearanceList;
  }

  @override
  void onInit() {
    super.onInit();
    retrieveUserAppearanceCounts();
    displayUserAppearanceCounts();
  }

  @override
  void onReady() async {
    super.onReady();
    userCounts.clear();
    await retrieveUserAppearanceCounts();
    displayUserAppearanceCounts();
  }
}

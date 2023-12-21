import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/utils/Core/helper/log_printer.dart';

import '../model/round_standing_model.dart';

class OverallBetPointController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Map<String, dynamic>> userCounts = <Map<String, dynamic>>[].obs;
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

  Future<Map<String, int>> calculateUserAppearanceCounts() async {
    final CollectionReference winnerCollection = firestore.collection('Winner');
    final QuerySnapshot querySnapshot = await winnerCollection.get();
    final Map<String, int> userAppearanceCounts = {};

    for (var document in querySnapshot.docs) {
      final data = document.data() as Map<String, dynamic>;
      calculateUserAppearanceCountsForDocument(data, userAppearanceCounts);
    }
    saveUserAppearanceCounts(userAppearanceCounts);

    return userAppearanceCounts;
  }

  void calculateUserAppearanceCountsForDocument(
      Map<String, dynamic> data, Map<String, int> userAppearanceCounts) {
    data.forEach((field, value) {
      if (value is List) {
        for (var userID in value) {
          userAppearanceCounts[userID] =
              (userAppearanceCounts[userID] ?? 0) + 1;
        }
      }
    });
  }

  Future<void> saveUserAppearanceCounts(
      Map<String, int> userAppearanceCounts) async {
    try {
      for (final userID in userAppearanceCounts.keys) {
        final appearanceCount = userAppearanceCounts[userID];
        await updateTotalBetPoint(userID, appearanceCount!);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving user appearance counts: $e');
      }
    }
  }

  Future<void> updateTotalBetPoint(
      String userID, int newAppearanceCount) async {
    try {
      final userDocRef = firestore.collection('User Information').doc(userID);
      await userDocRef.update({'total_bet_point': newAppearanceCount});
      logError(
          'Updated appearance count for user $userID: $newAppearanceCount');
    } catch (e) {
      if (kDebugMode) {
        print('Error updating total_bet_point: $e');
      }
    }
  }

  Future<List<RoundStandingsModel>> displayUserAppearanceCounts() async {
    final CollectionReference winnerCollection = firestore.collection('Winner');
    final QuerySnapshot querySnapshot = await winnerCollection.get();
    final List<RoundStandingsModel> rankings = [];

    for (var document in querySnapshot.docs) {
      final docId = document.id;
      final data = document.data() as Map<String, dynamic>;
      final userAppearanceCounts =
          await calculateUserAppearanceCountsForRound(data);
      rankings.add(RoundStandingsModel(docId, userAppearanceCounts));
    }

    for (var round in rankings) {
      round.userAppearanceCounts = Map.fromEntries(
          round.userAppearanceCounts.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value)));
    }

    // Sort the list of RoundStandingsModel by the highest appearance count within each round
    rankings.sort((a, b) {
      final int countA = a.userAppearanceCounts.isNotEmpty
          ? a.userAppearanceCounts.values.first
          : 0;
      final int countB = b.userAppearanceCounts.isNotEmpty
          ? b.userAppearanceCounts.values.first
          : 0;
      return countB.compareTo(countA);
    });

    return rankings;
  }

  Future<Map<String, int>> calculateUserAppearanceCountsForRound(
      Map<String, dynamic> data) async {
    final Map<String, int> userAppearanceCounts = {};

    data.forEach((field, value) {
      if (value is List) {
        for (var userID in value) {
          userAppearanceCounts[userID] =
              (userAppearanceCounts[userID] ?? 0) + 1;
        }
      }
    });

    return userAppearanceCounts;
  }

  @override
  void onInit() {
    super.onInit();
    retrieveUserAppearanceCounts();
    calculateUserAppearanceCounts();
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

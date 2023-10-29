import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';

class UserBetHistoryController extends GetxController {
  final firestoreInstance = FirebaseFirestore.instance;
  RxList<dynamic> betHistory = <dynamic>[].obs;

  @override
  void onInit() async {
    super.onInit();
    fetchUserBetHistory();
  }

  Future<void> fetchUserBetHistory() async {
    try {
      final userId =
          UserPreference.getUserid(); // Replace with the actual user ID

      final userDocRef = FirebaseFirestore.instance
          .collection('User Information')
          .doc(userId)
          .collection('round_point');
      final querySnapshot = await userDocRef.get();
      for (var element in querySnapshot.docs) {
        if (kDebugMode) {
          print(element);
        }
      }
      final userBetHistoryList = querySnapshot.docs.expand((doc) {
        final userData = doc.data();
        final betHistory = userData['round_bet'] as List<dynamic>?;
        if (betHistory != null) {
          return betHistory;
        }
        return betHistory!.toList();
      }).toList();
      if (userBetHistoryList.isEmpty) {
        // empty list scenario
        // display a message or handle it differently based on your requirements.
      } else {
        betHistory.value = userBetHistoryList;
      }
    } catch (e) {
      if (kDebugMode) {
        print('error while fetch bet history $e');
      }
    }
  }
}

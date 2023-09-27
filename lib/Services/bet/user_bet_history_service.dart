import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Model/bet/user_bet_history_model.dart';

class UserBetHistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserBetHistoryModel>> getUserBetHistory(String userId) async {
    final querySnapshot = await _firestore
        .collection("User Information")
        .doc(userId)
        .get();

    final List<UserBetHistoryModel> matchHistory = [];

    if (querySnapshot.exists) {
      final data = querySnapshot.data() as Map<String, dynamic>;
      final matches = data['betHistory'] as List<dynamic>;

      for (final match in matches) {
        matchHistory.add(UserBetHistoryModel.fromJson(match));
      }
    }

    return matchHistory;
  }
}

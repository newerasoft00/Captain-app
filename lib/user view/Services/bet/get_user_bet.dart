import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Model/bet/user_bet.dart';

class GetUserBetService {
  Stream<NewBet?> getUserBetStream(String matchKey, String userId) {
    final userBetRef = FirebaseFirestore.instance
        .collection("User'sBet")
        .doc(matchKey)
        .snapshots();

    return userBetRef.map((snapshot) {
      if (snapshot.exists) {
        final Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        final List<dynamic> bets = userData['bets'] ?? [];

        final userBetData = bets
            .where((bet) {
              final Map<String, dynamic> betData = Map<String, dynamic>.from(bet);
              return betData['userID'] == userId;
            })
            .toList()
            .firstOrNull;

        if (userBetData != null) {
          final userBet = NewBet.fromJson(userBetData);
          return userBet;
        }
      }
      return null;
    });
  }
}

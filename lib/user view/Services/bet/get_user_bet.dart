import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Model/bet/user_bet.dart';

class GetUserBetService {
  Stream<NewBet?> getUserBetStream(
      String roundId, String matchKey, String userId) {
    final roundRef =
        FirebaseFirestore.instance.collection("User'sBet").doc('Round 11');

    return roundRef.snapshots().map((roundSnapshot) {
      if (roundSnapshot.exists) {
        final roundData = roundSnapshot.data() as Map<String, dynamic>;
        final matchData = roundData[matchKey] as List<dynamic>;

        //final bets = matchData[matchKey] as List<dynamic> ?? [];

        final userBetData = matchData
            .where((bet) {
              final Map<String, dynamic> betData =
                  Map<String, dynamic>.from(bet);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Model/bet/user_bet.dart';

class GetUserBetService {
  Future<NewBet?> getUserBetByMatchKey(String matchKey, String userId) async {
    try {
      final DocumentSnapshot userBetDoc = await FirebaseFirestore.instance
          .collection("User'sBet")
          .doc(matchKey)
          .get();

      if (userBetDoc.exists) {
        final Map<String, dynamic> userData =
            userBetDoc.data() as Map<String, dynamic>;

        final List<dynamic> bets = userData['bets'] ?? [];

        final userBetData = bets
            .where((bet) {
              final Map<String, dynamic> betData =
                  Map<String, dynamic>.from(bet);
              return betData['userID'] == userId;
            })
            .toList()
            .firstOrNull;

        if (userBetData != null) {
          // Convert userBetData to UserBet object
          final userBet = NewBet.fromJson(userBetData);
          return userBet;
        }
      }

      return null; // Return null if no user bet found for the matchKey and userId
    } catch (e) {
      return null; // Handle the error as needed
    }
  }
}

extension FirstOrNull<T> on List<T> {
  T? get firstOrNull {
    if (isEmpty) {
      return null;
    }
    return first;
  }
}

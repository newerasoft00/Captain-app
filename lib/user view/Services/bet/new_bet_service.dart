import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Model/bet/user_bet.dart';

class NewBetService {
  Future<void> addDataToFirestore(
    String userId,
    String chosenbet,
    String matchKey,
    String winScore,
    String loseScore,
  ) async {
    try {
      final CollectionReference userBetCollection =
          FirebaseFirestore.instance.collection("User'sBet");

      // Assuming you have a user ID, use it to reference the user's document
      final DocumentReference userDocRef = userBetCollection.doc(matchKey);

      // Fetch the current data from Firestore
      final DocumentSnapshot userDoc = await userDocRef.get();

      NewBet newBet = NewBet(
        userID: userId,
        winTeam: chosenbet,
        winScore: winScore, // Convert to int
        loseScore: loseScore, // Convert to int
      );

      if (userDoc.exists) {
        // If the document exists, check if the user already has a bet in the list
        final List<dynamic> bets = userDoc.get('bets') ?? [];

        // Check if the user already has a bet in the list
        final bool userHasExistingBet = bets.any((bet) {
          final Map<String, dynamic> betData = Map<String, dynamic>.from(bet);
          return betData['userID'] == userId;
        });

        if (userHasExistingBet) {
          // If the user has an existing bet, update it
          final updatedBets = bets.map((bet) {
            final Map<String, dynamic> betData = Map<String, dynamic>.from(bet);
            if (betData['userID'] == userId) {
              return newBet
                  .toJson(); // Replace the existing bet with the new one
            }
            return bet;
          }).toList();

          await userDocRef.update({'bets': updatedBets});
        } else {
          // If the user does not have an existing bet, add the new bet
          bets.add(newBet.toJson());
          await userDocRef.update({'bets': bets});
        }
      } else {
        // If the document does not exist, create it with the new bet data
        await FirebaseFirestore.instance
            .collection("User'sBet")
            .doc(matchKey)
            .set({
          'bets': [newBet.toJson()], // Create a list with the new bet data
        });
      }
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }
}

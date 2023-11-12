import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../modules/bet_league/model/user_bet.dart';


class NewBetService {
  Future<void> addDataToFirestore(
    String roundID,
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
        final Map<String, dynamic> userData =
            userDoc.data() as Map<String, dynamic>;

        // Check if the matchKey field exists in the document
        if (userData.containsKey('bets')) {
          final List<dynamic> matchBet = userData['bets'] ?? [];

          // Check for an existing bet, update it, or add a new bet
          final bool userHasExistingBet = matchBet.any((bet) {
            final Map<String, dynamic> betData = Map<String, dynamic>.from(bet);
            return betData['userID'] == userId;
          });

          if (userHasExistingBet) {
            final updatedBets = matchBet.map((bet) {
              final Map<String, dynamic> betData =
                  Map<String, dynamic>.from(bet);
              if (betData['userID'] == userId) {
                return newBet
                    .toJson(); // Replace the existing bet with the new one
              }
              return bet;
            }).toList();

            await userDocRef.update({'bets': updatedBets});
          } else {
            matchBet.add(newBet.toJson());
            await userDocRef.update({'bets': matchBet});
          }
        } else {
          // If the matchKey field does not exist, create it with the new bet data
          await userDocRef.update({
            'bets': [newBet.toJson()]
          });
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
      // Handle any potential errors
      if (kDebugMode) {
        print('Error adding data to Firestore: $e');
      }
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Model/bet/user_bet.dart';

class NewBetService {
  Future<void> addDataToFirestore(
      String userId, String chosenbet, String matchKey, String winScore, String loseScore) async {
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
        winScore:winScore, // Convert to int
        loseScore: loseScore, // Convert to int
      );

      if (userDoc.exists) {
        // If the document exists, update it with the new bet data
        final List<dynamic> bets = userDoc.get('bets') ?? [];
        bets.add(newBet.toJson()); // Convert NewBet to JSON and add it to the list
        await userDocRef.update({'bets': bets});
      } else {
        // If the document does not exist, create it with the new bet data
        await FirebaseFirestore.instance.collection("User'sBet").doc(matchKey).set({
          'bets': [newBet.toJson()], // Create a list with the new bet data
        });
        
        /* final CollectionReference checkBetCollection =
            FirebaseFirestore.instance.collection("checkBet");
        final DocumentReference checkBetDocRef =
            checkBetCollection.doc(matchKey);
        await checkBetDocRef.set({userId: true}); */
      }
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }
}

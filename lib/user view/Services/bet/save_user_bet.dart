import 'package:cloud_firestore/cloud_firestore.dart';

class SaveUserBet {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendBetDataToFirestore(
      String userId,
      String matchId,
      String matchDate,
      String teams,
      String userBet,
  ) async {
    try {
      final userDocRef = _firestore.collection("User Information").doc(userId);

      // Check if the user document exists
      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        // If the user document exists, update or create the "betHistory" array
        final userDocData = userDocSnapshot.data() as Map<String, dynamic>;
        final betHistory = userDocData['betHistory'] as List<dynamic>;

        // Create a new bet entry
        final betEntry = {
          'match_Id': matchId,
          'match_Date': matchDate,
          'teams': teams,
          'user_bet': userBet,
        };

        // Add the new bet entry to the "betHistory" array
        betHistory.add(betEntry);

        // Update the user document with the modified "betHistory" array
        await userDocRef.set(
          {'betHistory': betHistory},
          SetOptions(merge: true), // Merge with existing data
        );
      } else {
        // If the user document doesn't exist, create it with the "betHistory" array
        await userDocRef.set(
          {
            'betHistory': [
              {
                'match_Id': matchId,
                'match_Date': matchDate,
                'teams': teams,
                'user_bet': userBet,
              }
            ]
          },
        );
      }
    } catch (e) {
      // print('Error sending bet data to Firestore: $e');
      // Handle error, show error message, or retry logic here.
    }
  }
}

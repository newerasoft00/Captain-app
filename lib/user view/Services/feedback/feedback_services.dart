import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';

import '../../../Model/feedback/feedback_model.dart';

class FeedbackService {
  final CollectionReference feedbackCollection =
      FirebaseFirestore.instance.collection('Feedback');

  Future<void> saveFeedback(FeedbackModel feedback) async {
    final userId = UserPreference.getUserid();
    final snapshot = await feedbackCollection.doc(userId).get();

    if (snapshot.exists) {
      // Document exists, update the 'feedback' field
      await feedbackCollection.doc(userId).update({
        'feedback': FieldValue.arrayUnion([feedback.toJson()]),
      });
    } else {
      // Document doesn't exist, create a new document
      await feedbackCollection.doc(userId).set({
        'feedback': [feedback.toJson()],
      });
    }
  }

  Future<FeedbackModel?> getFeedback(String userId) async {
    final snapshot = await feedbackCollection.doc(userId).get();
    if (snapshot.exists) {
      return FeedbackModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}

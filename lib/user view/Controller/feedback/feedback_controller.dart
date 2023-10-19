import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Model/feedback/feedback_model.dart';
import '../../Services/feedback/feedback_services.dart';

class FeedbackController extends GetxController {
  final feedbackKey = GlobalKey<FormState>();

  final FeedbackService _feedbackService = FeedbackService();
  final Rx<FeedbackModel?> userFeedback = Rx<FeedbackModel?>(null);
  RxString feedbackSubject = ''.obs;
  RxDouble rating = 1.0.obs;

  Future<void> saveUserFeedback() async {
    await _feedbackService.saveFeedback(FeedbackModel(
        rating: rating.toString(), subject: feedbackSubject.value));
    userFeedback.value = FeedbackModel(
        rating: rating.toString(), subject: feedbackSubject.value);
  }

  Future<void> loadUserFeedback(String userId) async {
    final feedback = await _feedbackService.getFeedback(userId);
    userFeedback.value = feedback;
  }

  String? validateSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Subject is required';
    }
    return null;
  }
}

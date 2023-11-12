class FeedbackModel {
  final String rating;
  final String subject;

  FeedbackModel({required this.rating, required this.subject});

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'subject': subject,
    };
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> map) {
    return FeedbackModel(
      rating: map['rating'],
      subject: map['subject'],
    );
  }
}

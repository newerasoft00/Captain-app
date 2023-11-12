class UserBetHistoryModel {
  final String matchId;
  final String teams;
  final String userBet;

  UserBetHistoryModel({
    required this.matchId,
    required this.teams,
    required this.userBet,
  });

  Map<String, dynamic> toJson() {
    return {
      'match_Id': matchId,
      'teams': teams,
      'user_bet': userBet,
    };
  }

  factory UserBetHistoryModel.fromJson(Map<String, dynamic> json) {
    return UserBetHistoryModel(
      matchId: json['match_Id'],
      teams: json['teams'],
      userBet: json['match_score'],
    );
  }
}

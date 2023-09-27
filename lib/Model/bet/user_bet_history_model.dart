class UserBetHistoryModel {
  final String matchId;
  final String matchDate;
  final String teams;
  final String userBet;

  UserBetHistoryModel({
    required this.matchId,
    required this.matchDate,
    required this.teams,
    required this.userBet,
  });

  Map<String, dynamic> toJson() {
    return {
      'match_Id': matchId,
      'match_Date': matchDate,
      'teams': teams,
      'user_bet': userBet,
    };
  }

  factory UserBetHistoryModel.fromJson(Map<String, dynamic> json) {
    return UserBetHistoryModel(
      matchId: json['match_Id'],
      matchDate: json['match_Date'],
      teams: json['teams'],
      userBet: json['user_bet'],
    );
  }
}

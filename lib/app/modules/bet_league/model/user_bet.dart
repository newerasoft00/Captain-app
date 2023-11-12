class NewBet {
  final String userID;
  final String winTeam;
  final String winScore;
  final String loseScore;

  NewBet({
    required this.userID,
    required this.winTeam,
    required this.winScore,
    required this.loseScore,
  });

  factory NewBet.fromJson(Map<String, dynamic> json) {
    return NewBet(
      userID: json['userID'],
      winTeam: json['winTeam'],
      winScore: json['winScore'],
      loseScore: json['loseScore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'winTeam': winTeam,
      'winScore': winScore,
      'loseScore': loseScore,
    };
  }
}

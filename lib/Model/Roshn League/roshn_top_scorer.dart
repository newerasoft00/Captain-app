class RoshnTopScorer {
  final int playerPlace;
  final String playerName;
  final int playerKey;
  final String teamName;
  final int teamKey;
  final int goals;
  final int assists;
  final int penaltyGoals;

  RoshnTopScorer({
    required this.playerPlace,
    required this.playerName,
    required this.playerKey,
    required this.teamName,
    required this.teamKey,
    required this.goals,
    required this.assists,
    required this.penaltyGoals,
  });

  factory RoshnTopScorer.fromJson(Map<String, dynamic> json) {
    return RoshnTopScorer(
      playerPlace: json['player_place'] ?? 0,
      playerName: json['player_name'] ?? '',
      playerKey: json['player_key'] ?? 0,
      teamName: json['team_name'] ?? '',
      teamKey: json['team_key'] ?? 0,
      goals: json['goals'] ?? 0,
      assists: json['assists'] ?? 0,
      penaltyGoals: json['penalty_goals'] ?? 0,

    );
  }
}

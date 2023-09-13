class Standings {
  int teamid;
  int participantId;
  int sportId;
  int leagueId;
  int seasonId;
  int stageId;
  int roundId;
  int standingRuleId;
  int position;
  String result;
  int points;

  Standings({
    required this.teamid,
    required this.participantId,
    required this.sportId,
    required this.leagueId,
    required this.seasonId,
    required this.stageId,
    required this.roundId,
    required this.standingRuleId,
    required this.position,
    required this.result,
    required this.points,
  });

  factory Standings.fromJson(Map<String, dynamic> json) {
    return Standings(
      teamid: json['id'],
      participantId: json['participant_id'],
      sportId: json['sport_id'],
      leagueId: json['league_id'],
      seasonId: json['season_id'],
      stageId: json['stage_id'],
      roundId: json['round_id'],
      standingRuleId: json['standing_rule_id'],
      position: json['position'],
      result: json['result'],
      points: json['points'],
    );
  }
}
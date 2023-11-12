class Standingsbondis {
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

  Standingsbondis({
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

  factory Standingsbondis.fromJson(Map<String, dynamic> json) {
    return Standingsbondis(
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

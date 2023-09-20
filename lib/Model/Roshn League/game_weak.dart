class RoshnMatch {
  final String eventDate;
  final String eventLive;
  final String eventHomeTeam;
  final String eventAwayTeam;
  final String eventFinalResult;
  final String eventStatus;
  final String leagueRound;
  final String leagueName;
  final String leagueSeason;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final String eventHomeFormation;
  final String eventAwayFormation;
  final int hometeamkey;

  RoshnMatch( {
    required this.hometeamkey,
    required this.eventDate,
    required  this.eventLive,
    required this.eventHomeTeam,
    required this.eventAwayTeam,
    required this.eventFinalResult,
    required this.eventStatus,
    required this.leagueRound,
    required this.leagueName,
    required this.leagueSeason,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.eventHomeFormation,
    required this.eventAwayFormation,
  });

  factory RoshnMatch.fromJson(Map<String, dynamic> json) {
    return RoshnMatch(
      eventLive: json['event_live']??'',
      leagueName: json['league_name'] ?? '',
      eventDate: json['event_date'] ?? '',
      eventHomeTeam: json['event_home_team'] ?? '',
      eventAwayTeam: json['event_away_team'] ?? '',
      eventFinalResult: json['event_final_result'] ?? '',
      eventStatus: json['event_status'] ?? '',
      leagueRound: json['league_round'] ?? '',
      leagueSeason: json['league_season'] ?? '',
      homeTeamLogo: json['home_team_logo'] ?? '',
      awayTeamLogo: json['away_team_logo'] ?? '',
      eventHomeFormation: json['event_home_formation'] ?? '',
      eventAwayFormation: json['event_away_formation'] ?? '',
      hometeamkey: json['home_team_key']??0,
    );
  }
}

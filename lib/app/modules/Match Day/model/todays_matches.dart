class ToDaysMatch {
  final int eventKey;
  final String eventDate;
  final String eventTime;
  final String eventLive;
  final String eventHomeTeam;
  final int homeTeamKey;
  final String eventAwayTeam;
  final int awayTeamKey;
  final String eventFinalResult;
  final String eventStadium;
  final String eventReferee;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final String leagueName;

  ToDaysMatch({
    required this.eventKey,
    required this.eventDate,
    required this.eventLive,
    required this.eventTime,
    required this.eventHomeTeam,
    required this.homeTeamKey,
    required this.eventAwayTeam,
    required this.awayTeamKey,
    required this.eventFinalResult,
    required this.eventStadium,
    required this.eventReferee,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.leagueName,
  });

  factory ToDaysMatch.fromJson(Map<String, dynamic> json) {
    return ToDaysMatch(
      eventKey: json['event_key']??'',
      eventDate: json['event_date']??'',
      eventTime: json['event_time']??'',
      eventLive: json['event_live']??'',
      eventHomeTeam: json['event_home_team']??'',
      homeTeamKey: json['home_team_key']??'',
      eventAwayTeam: json['event_away_team']??'',
      awayTeamKey: json['away_team_key']??'',
      eventFinalResult: json['event_final_result']??'',
      eventStadium: json['event_stadium']??'',
      eventReferee: json['event_referee']??'',
      homeTeamLogo: json['home_team_logo']??'',
      awayTeamLogo: json['away_team_logo']??'',
      leagueName: json['league_name']??'',
    );
  }
}

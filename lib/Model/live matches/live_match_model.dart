class LiveMatch {
  int eventKey;
  String eventDate;
  String eventTime;
  String eventHomeTeam;
  int homeTeamKey;
  String eventAwayTeam;
  int awayTeamKey;
  String eventHalftimeResult;
  String eventFinalResult;
  String leagueName;
  String leagueRound;
  String leagueSeason;
  String eventStadium;
  String homeTeamLogo;
  String awayTeamLogo;
  String leagueLogo;
  String countryLogo;
  String eventHomeFormation;
  String eventAwayFormation;
  String eventlivetime;

  LiveMatch({
    required this.eventKey,
    required this.eventDate,
    required this.eventTime,
    required this.eventHomeTeam,
    required this.homeTeamKey,
    required this.eventAwayTeam,
    required this.awayTeamKey,
    required this.eventHalftimeResult,
    required this.eventFinalResult,
    required this.leagueName,
    required this.leagueRound,
    required this.leagueSeason,
    required this.eventStadium,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.leagueLogo,
    required this.countryLogo,
    required this.eventHomeFormation,
    required this.eventAwayFormation,
    required this.eventlivetime
  });

  factory LiveMatch.fromJson(Map<String, dynamic> json) {
    return LiveMatch(
      eventKey: json['event_key']??'',
      eventDate: json['event_date']??'',
      eventTime: json['event_time']??'',
      eventHomeTeam: json['event_home_team']??'',
      homeTeamKey: json['home_team_key']??'',
      eventAwayTeam: json['event_away_team']??'',
      awayTeamKey: json['away_team_key']??'',
      eventHalftimeResult: json['event_halftime_result']??'',
      eventFinalResult: json['event_final_result']??'',
      leagueName: json['league_name']??'',
      leagueRound: json['league_round']??'',
      leagueSeason: json['league_season']??'',
      eventStadium: json['event_stadium']??'',
      homeTeamLogo: json['home_team_logo']??'',
      awayTeamLogo: json['away_team_logo']??'',
      leagueLogo: json['league_logo']??'',
      countryLogo: json['country_logo']??'',
      eventHomeFormation: json['event_home_formation']??'',
      eventAwayFormation: json['event_away_formation']??'',
      eventlivetime: json['event_status']??'',
    );
  }
}

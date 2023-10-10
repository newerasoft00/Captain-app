class Head2Head {
  final int eventKey;
  final String eventDate;
  final String eventTime;
  final String eventHomeTeam;
  final String eventAwayTeam;
  final String eventHalftimeResult;
  final String eventFinalResult;
  final String eventStatus;
  final String countryName;
  final String leagueName;
  final String leagueRound;

  Head2Head({
    required this.eventKey,
    required this.eventDate,
    required this.eventTime,
    required this.eventHomeTeam,
    required this.eventAwayTeam,
    required this.eventHalftimeResult,
    required this.eventFinalResult,
    required this.eventStatus,
    required this.countryName,
    required this.leagueName,
    required this.leagueRound,
  });

  factory Head2Head.fromJson(Map<String, dynamic> json) {
    return Head2Head(
      eventKey: json['event_key'],
      eventDate: json['event_date'],
      eventTime: json['event_time'],
      eventHomeTeam: json['event_home_team'],
      eventAwayTeam: json['event_away_team'],
      eventHalftimeResult: json['event_halftime_result'],
      eventFinalResult: json['event_final_result'],
      eventStatus: json['event_status'],
      countryName: json['country_name'],
      leagueName: json['league_name'],
      leagueRound: json['league_round'],
    );
  }
}

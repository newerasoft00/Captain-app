import 'package:intl/intl.dart';
import 'match_result.dart';
import 'team_info.dart';

class MatchDay {
  final int matchID;
  final String matchDateTime;
  final String timeZoneID;
  final int leagueId;
  final String leagueName;
  final int leagueSeason;
  final String leagueShortcut;
  final String matchDateTimeUTC;
  final int? scoreTeam1;
  final int? scoreTeam2;
  final bool matchFinished;
  final Team team1;
  final Team team2;

  final List<MatchResult>? matchResults; // New field for matchResults

  MatchDay(

  {
    required this.scoreTeam1, required this.scoreTeam2, 

    required this.matchID,
    required this.matchDateTime,
    required this.timeZoneID,
    required this.leagueId,
    required this.leagueName,
    required this.leagueSeason,
    required this.leagueShortcut,
    required this.matchDateTimeUTC,
    required this.matchFinished,
    required this.team1,
    required this.team2,
    this.matchResults,
  });

  factory MatchDay.fromJson(Map<String, dynamic> json) {
    // Parse JSON and create a Match object

    final inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    final outputFormat = DateFormat("yyyy-MM-dd  hh");

    final formattedMatchDateTime =
        outputFormat.format(inputFormat.parse(json['matchDateTime']));
    // Parse matchResults only if matchIsFinished is true
    final List<MatchResult> matchResults = [];
    if (json['matchIsFinished'] == true) {
      final resultsJson = json['matchResults'] as List<dynamic>;
      matchResults.addAll(
        resultsJson
            .where((resultJson) => resultJson['resultName'] == 'Endergebnis')
            .map((resultJson) => MatchResult.fromJson(resultJson)),
      );
    }
    return MatchDay(
      matchID: json['matchID'],
      matchDateTime: formattedMatchDateTime,
      timeZoneID: json['timeZoneID'],
      leagueId: json['leagueId'],
      leagueName: json['leagueName'],
      leagueSeason: json['leagueSeason'],
      leagueShortcut: json['leagueShortcut'],
      matchDateTimeUTC: json['matchDateTimeUTC'],
      matchFinished: json['matchIsFinished'],
      team1: Team.fromJson(json['team1']),
      team2: Team.fromJson(json['team2']),
      matchResults: matchResults,
      scoreTeam1: json['matchResults'][1]['pointsTeam1']??'.',
      scoreTeam2: json['matchResults'][1]['pointsTeam2']??'.',
    );
  }
}

String formattedDateTime(String dateTimeString) {
  final inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
  final outputFormat = DateFormat("yyyy-MM-dd hh");

  final dateTime = inputFormat.parse(dateTimeString);
  return outputFormat.format(dateTime);
}

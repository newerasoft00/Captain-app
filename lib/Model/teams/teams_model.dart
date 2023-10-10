import 'player_model.dart';

class TeamsDetails {
  final int teamKey;
  final String teamName;
  final String teamLogo;
  final List<PlayerModel> players;

  TeamsDetails({
    required this.teamKey,
    required this.teamName,
    required this.teamLogo,
    required this.players,

  });

  factory TeamsDetails.fromJson(Map<String, dynamic> json) {
    return TeamsDetails(
      teamKey: json['team_key'] as int,
      teamName: json['team_name'] as String,
      teamLogo: json['team_logo'] as String, 
      players: json['players'],
    );
  }
}

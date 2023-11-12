class Team {
  final int teamId;
  final String teamName;
  final String shortName;
  final String teamIconUrl;

  Team({
    required this.teamId,
    required this.teamName,
    required this.shortName,
    required this.teamIconUrl,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamId: json['teamId'],
      teamName: json['teamName'],
      shortName: json['shortName'],
      teamIconUrl: json['teamIconUrl'],
    );
  }
}


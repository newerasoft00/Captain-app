class MatchResult {
  final int resultID;
  final String resultName;
  final int pointsTeam1;
  final int pointsTeam2;
  final int resultOrderID;
  final int resultTypeID;
  final String? resultDescription;

  MatchResult({
    required this.resultID,
    required this.resultName,
    required this.pointsTeam1,
    required this.pointsTeam2,
    required this.resultOrderID,
    required this.resultTypeID,
    this.resultDescription,
  });

  factory MatchResult.fromJson(Map<String, dynamic> json) {
    return MatchResult(
      resultID: json['resultID'] ?? '',
      resultName: json['resultName'] ?? '',
      pointsTeam1: json['pointsTeam1'] ?? '',
      pointsTeam2: json['pointsTeam2'] ?? '',
      resultOrderID: json['resultOrderID'] ?? '',
      resultTypeID: json['resultTypeID'] ?? '',
      resultDescription: json['resultDescription'] ?? '',
    );
  }
}

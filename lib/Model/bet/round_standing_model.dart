class RoundStandingsModel {
  final String roundId; // You can use round dates or IDs here
  Map<String, int> userAppearanceCounts;

  RoundStandingsModel(this.roundId, this.userAppearanceCounts);
}

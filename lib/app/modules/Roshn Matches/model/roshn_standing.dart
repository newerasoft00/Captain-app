class Standing {
  int standingPlace;
  String standingPlaceType;
  String standingTeam;
  int standingP;
  int standingW;
  int standingD;
  int standingL;
  int standingF;
  int standingA;
  int standingGD;
  int standingPTS;
  String leagueSeason;
  String standingUpdated;
  String teamLogo;

  Standing({
    required this.standingPlace,
    required this.standingPlaceType,
    required this.standingTeam,
    required this.standingP,
    required this.standingW,
    required this.standingD,
    required this.standingL,
    required this.standingF,
    required this.standingA,
    required this.standingGD,
    required this.standingPTS,
    required this.leagueSeason,
    required this.standingUpdated,
    required this.teamLogo,
  });

  factory Standing.fromJson(Map<String, dynamic> json) {
    return Standing(
      standingPlace: json['standing_place']??'',
      standingPlaceType: json['standing_place_type']??'',
      standingTeam: json['standing_team']??'',
      standingP: json['standing_P']??'',
       teamLogo:json['team_logo']?? '',
      standingW: json['standing_W']??'',
      standingD: json['standing_D']??'',
      standingL: json['standing_L']??'',
      standingF: json['standing_F']??'',
      standingA: json['standing_A']??'',
      standingGD: json['standing_GD']??'',
      standingPTS: json['standing_PTS']??'',
      leagueSeason:json['league_season']??'' ,
      standingUpdated: json['standing_updated']??''
      // Add the rest of the fields here.
    );
  }
}

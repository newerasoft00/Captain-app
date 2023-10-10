import 'package:sportsbet/main.dart';

import '../../utils/strings.dart';

class UserPreference{


 static Future<void> setUserId(String userid) =>
      sharedpref!.setString('user_Id', userid);
  static String getUserid() {
    if (sharedpref != null) {
      return sharedpref!.getString('user_Id') ?? "";
    }
    return ""; 
  } 
  

  static Future<void> setIsLoggedIn(bool login) =>
      sharedpref!.setBool('logged_in', login) ;
  static bool isLoggedIn() => sharedpref!.getBool('logged_in') ?? false;

static Future<void> setSelectedLeague(String leagueName) =>
    sharedpref!.setString('selected_league', leagueName);

static String getSelectedLeague() {
  if (sharedpref != null) {
    return sharedpref!.getString('selected_league') ?? "Roshn League";
  }
  return "";
}
static Future<void> setSelectedLeagelogo(String leagueName) =>
    sharedpref!.setString('selected_league_logo', leagueName);

static String getSelectedLeaguelogo() {
  if (sharedpref != null) {
    return sharedpref!.getString('selected_league_logo') ?? "assets/Roshn_Saudi_League_Logo.svg.png";
  }
  return "";
}

static Future<void> setSelectedLeagueKeys(String leagueName) =>
    sharedpref!.setString('selected_league_Key', leagueName);

static String getSelectedLeaguekeys() {
  if (sharedpref != null) {
    return sharedpref!.getString('selected_league_Key') ?? "278";
  }
  return "";
}static Future<void> setLeagueUrl(String leagueUri) =>
    sharedpref!.setString('Uri', leagueUri);

static String getLeagueUrl() {
  if (sharedpref != null) {
    return sharedpref!.getString('Uri')
     ?? "$allsportsapi$fixturesEndPoint$allsportsapiKey&from=2023-08-11&to=2024-05-27&leagueId=${UserPreference.getSelectedLeaguekeys()}";
  }
  return "";
}

  static Future<void> setTheme(bool lighttheme) =>
      sharedpref!.setBool('ligh_theme', lighttheme) ;
  static bool islighttheme() => sharedpref!.getBool('ligh_theme') ?? true;

}
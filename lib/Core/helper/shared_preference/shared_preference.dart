import 'package:sportsbet/main.dart';

class UserPreference{
   static Future<void> setUserId(String userid) =>
      sharedpref!.setString('user_Id', userid);
 static String getUserid() => sharedpref!.getString('user_Id') ?? "";
  
  

  static Future<void> setIsLoggedIn(bool login) =>
      sharedpref!.setBool('logged_in', login) ;

  static bool isLoggedIn() => sharedpref!.getBool('logged_in') ?? false;

  static Future<void> setTheme(bool lighttheme) =>
      sharedpref!.setBool('ligh_theme', lighttheme) ;
  static bool islighttheme() => sharedpref!.getBool('ligh_theme') ?? true;

}
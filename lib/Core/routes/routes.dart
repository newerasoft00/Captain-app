import 'package:get/get.dart';
import 'package:sportsbet/user%20view/View/Screens/Auth/Login/login_screen.dart';
import 'package:sportsbet/user%20view/View/Screens/Auth/Login/signup_screen.dart';
import 'package:sportsbet/user%20view/View/Screens/Home/home_screen.dart';
import 'package:sportsbet/user%20view/View/Screens/Profile/profile_screen.dart';
import 'package:sportsbet/user%20view/View/Screens/standing/standings.dart';

class Routes {
  static String loginscreen = '/loginscreen';
  static String signupScreen = '/signupScreen';
  static String homeScreen = '/homeScreen';
  static String standingsScreen = '/standingsScreen';
  static String profileScreen = '/profileScreen';

  static List<GetPage> getPages = [
    GetPage(
      name: Routes.loginscreen,
      page: () => const LoginScreen(),      
    ), 
    GetPage(
      name: Routes.signupScreen,
      page: () => const SignUpScreen(),      
    ), 
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),      
    ),
     GetPage(
      name: Routes.standingsScreen,
      page: () => const StandingsScreen(),      
    ),
      GetPage(
      name: Routes.profileScreen,
      page: () => const ProfileScreen(),      
    ),
  ];
}


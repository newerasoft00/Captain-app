import 'package:get/get.dart';
import 'package:sportsbet/user%20view/Screens/Auth/Login/login_screen.dart';
import 'package:sportsbet/user%20view/Screens/Auth/Login/signup_screen.dart';
import 'package:sportsbet/user%20view/Screens/Home/home_screen.dart';
import 'package:sportsbet/user%20view/Screens/Profile/profile_screen.dart';
import 'package:sportsbet/user%20view/Screens/on_boarding/on_boarding_screen.dart';

import '../../user view/View/Screens/standing/standings.dart';
import '../../user view/View/Screens/user feedback/feedback_screen.dart';

class Routes {

  static String loginscreen = '/loginscreen';
  static String signupScreen = '/signupScreen';
  static String homeScreen = '/homeScreen';
  static String standingsScreen = '/standingsScreen';
  static String profileScreen = '/profileScreen';
  static String feedbackScreen = '/FeedBackScreen';
  static String onBoarding = '/OnBoardingScreen';

  static List<GetPage> getPages = [
    GetPage(name: Routes.onBoarding, page: () => const OnBoardingScreen()),
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
        transition: Transition.fadeIn
    ),
    GetPage(
      name: Routes.profileScreen,
      page: () => const ProfileScreen(),
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: Routes.feedbackScreen,
        page: () => const FeedBackScreen(),
        transition: Transition.fadeIn)
  ];
}

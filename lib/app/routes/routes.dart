import 'package:get/get.dart';
import 'package:sportsbet/app/modules/Profile/profile_screen.dart';
import 'package:sportsbet/app/modules/auth/login_screen.dart';
import 'package:sportsbet/app/modules/auth/signup_screen.dart';
import 'package:sportsbet/app/modules/home/home_screen.dart';
import 'package:sportsbet/app/modules/on_boarding/on_boarding_screen.dart';
import 'package:sportsbet/app/modules/standing/standings.dart';
import 'package:sportsbet/app/modules/user%20feedback/feedback_screen.dart';



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

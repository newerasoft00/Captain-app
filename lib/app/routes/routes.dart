import 'package:get/get.dart';
import 'package:captain/app/modules/Vote/best_goals_screen.dart';
import 'package:captain/app/modules/Vote/best_player_screen.dart';
import 'package:captain/app/modules/Vote/vote_binding.dart';
import 'package:captain/app/modules/auth/login_screen.dart';
import 'package:captain/app/modules/auth/signup_screen.dart';
import 'package:captain/app/modules/bet_league/bet_league.dart';
import 'package:captain/app/modules/home/home_bindings.dart';
import 'package:captain/app/modules/home/home_screen.dart';
import 'package:captain/app/modules/on_boarding/on_boarding_screen.dart';
import 'package:captain/app/modules/on_boarding/onboarding_bindings.dart';
import 'package:captain/app/modules/profile/profile_bindings.dart';
import 'package:captain/app/modules/profile/user_bet_history_screen.dart';
import 'package:captain/app/modules/standing/standing_binding.dart';
import 'package:captain/app/modules/standing/standings.dart';
import 'package:captain/app/modules/user%20feedback/feedback_binding.dart';
import 'package:captain/app/modules/user%20feedback/feedback_screen.dart';

class Routes {
  static String loginscreen = '/loginscreen';
  static String signupScreen = '/signupScreen';
  static String homeScreen = '/homeScreen';
  static String standingsScreen = '/standingsScreen';
  static String feedbackScreen = '/FeedBackScreen';
  static String onBoarding = '/OnBoardingScreen';
  static String votePage = '/VotePage';
  static String videoScreen = '/VideoScreen';
  static String profileSceren = '/ProfileScreen';
  static String betLeague = '/BetLeague';
  static String betHistory = '/BetHistoryScreen';
  static String matchDetailsScreen = '/matchDetailsScreen';

  static List<GetPage> getPages = [
    GetPage(
        name: Routes.onBoarding,
        page: () => const OnBoardingScreen(),
        binding: OnBoardingBindings()),
    GetPage(
      name: Routes.loginscreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.signupScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      binding: HomeBindiings(),
      name: Routes.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
        binding: StandingBinding(),
        name: Routes.standingsScreen,
        page: () => const StandingsScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.feedbackScreen,
        binding: FeedBackBinding(),
        page: () => const FeedBackScreen(),
        transition: Transition.fadeIn),
    GetPage(
        binding: VoteBinding(), name: Routes.votePage, page: () => VotePage()),
    GetPage(
        name: Routes.videoScreen,
        binding: VideoBinding(),
        page: () => const VideoScreen(),
        transition: Transition.fadeIn),
    GetPage(
      name: Routes.betLeague,
      page: () => const BetLeague(),
    ),
    GetPage(
        name: Routes.betHistory,
        page: () => UserBetHistoryScreen(),
        binding: BetHistoryBindings()),
  ];
}

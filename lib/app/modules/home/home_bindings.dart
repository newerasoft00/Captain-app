import 'package:get/get.dart';
import 'package:sportsbet/app/modules/Animation%20Controller/animation_controller.dart';
import 'package:sportsbet/app/modules/Match%20Day/controller/live_controller.dart';
import 'package:sportsbet/app/modules/Roshn%20Matches/controller/roshn_match_controller.dart';
import 'package:sportsbet/app/modules/Roshn%20Matches/controller/roshn_standings_controller.dart';
import 'package:sportsbet/app/modules/bet_league/controller/overall_bet_point_controller.dart';
import 'package:sportsbet/app/modules/home/home_controller.dart';
import 'package:sportsbet/app/modules/profile/controller/profile_controller.dart';
import '../profile/controller/image_picker_controller.dart';

class HomeBindiings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(RoshnMatchController());
    Get.put(MyAnimationController());
    Get.put(LiveMatchController());
    Get.put(RoshnStandingsController());
    Get.put(OverallBetPointController());
    Get.put(ProfileController());
    Get.put(ImagePickerController());
  }
}

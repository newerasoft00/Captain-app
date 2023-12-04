import 'package:get/get.dart';
import 'package:sportsbet/app/modules/bet_league/controller/overall_bet_point_controller.dart';

import 'controller/user_round_point.dart';

class RoshanMatchBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(OverallBetPointController());
    Get.put(RoundPintController());
  }
}

import 'package:get/get.dart';
import 'package:captain/app/modules/Roshn%20Matches/controller/bet_controller.dart';
import 'package:captain/app/modules/Roshn%20Matches/controller/roshn_match_controller.dart';

class RoshanMatchBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RoshnMatchController());
    Get.put(BetOptionController());
  }
}

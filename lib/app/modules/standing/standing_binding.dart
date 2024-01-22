import 'package:get/get.dart';
import 'package:captain/app/modules/Roshn%20Matches/controller/standings_controller.dart';

class StandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StandingsController());
  }
}

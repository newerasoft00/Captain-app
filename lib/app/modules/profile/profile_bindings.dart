import 'package:get/get.dart';
import 'package:captain/app/modules/profile/controller/user_bet_history_controller.dart';

class BetHistoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserBetHistoryController());
  }
}

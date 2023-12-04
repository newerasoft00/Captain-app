import 'package:get/get.dart';
import 'package:sportsbet/app/modules/profile/controller/user_bet_history_controller.dart';

// class ProfileBinding extends Bindings {
// @override
// void dependencies() {
//     Get.put(ProfileController());
//     Get.put(ImagePickerController());
//   }
// }
class BetHistoryBindings extends Bindings {
@override
void dependencies() {
    Get.put(UserBetHistoryController());
  }
}

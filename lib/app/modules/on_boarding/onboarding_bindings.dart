import 'package:get/get.dart';
import 'package:sportsbet/app/modules/on_boarding/controller/page_indecator_controller.dart';

class OnBoardingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(OnBoardingController());
  }
}

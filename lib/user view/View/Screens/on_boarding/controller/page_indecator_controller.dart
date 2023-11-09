import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/Core/routes/routes.dart';

class OnBoardingController extends GetxController {
  final controller = PageController();
  final page = 0.obs;

  void onPageChanged(int pageIndex) {
    page.value = pageIndex;
  }

  void nextButton() {
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    update();
  }

  void backButton() {
    controller.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    update();
  }

  void goButton() async {
    await UserPreference.setIsFirstTime(true);
    Get.offAllNamed(Routes.homeScreen);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final RxBool islightMode = true.obs;

  void toggleTheme() {
    if (islightMode.value) {
      Get.changeThemeMode(ThemeMode.dark);
      islightMode.value = false;
    } else {
      Get.changeThemeMode(ThemeMode.light);
      islightMode.value = true;
    }
  }

  void showThemeChangeDialog() {
    Get.defaultDialog(
      title: "Theme Changed",
      middleText: "The theme has been changed.",
    );
    Future.delayed(const Duration(seconds: 4), () {
      Get.back(); // Close the dialog
    });
  }
}

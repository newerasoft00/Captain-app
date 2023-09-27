import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final RxBool islightMode = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  void toggleTheme() {
    if (islightMode.value) {
      Get.changeThemeMode(ThemeMode.dark);
      islightMode.value = false;
    } else {
      Get.changeThemeMode(ThemeMode.light);
      islightMode.value = true;
    }

    _saveThemePreference(islightMode.value);
  }

  void _saveThemePreference(bool isLightMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLightMode', isLightMode);
  }

  void _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLightMode = prefs.getBool('isLightMode');

    if (isLightMode != null) {
      islightMode.value = isLightMode;
      Get.changeThemeMode(isLightMode ? ThemeMode.light : ThemeMode.dark);
    }
  }
}

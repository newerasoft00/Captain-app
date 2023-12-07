import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dark_light_theme_file.dart';

class ThemeController extends GetxController {
  final RxBool islightMode = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  void toggleTheme() {
    if (islightMode.value) {
      Get.changeTheme(dark); // Change to the light theme
      islightMode.value = false;
    } else {
      Get.changeTheme(blueTheme); // Change to the dark theme
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
      Get.changeTheme(isLightMode ? blueTheme : dark); // Apply the saved theme
    }
  }
}

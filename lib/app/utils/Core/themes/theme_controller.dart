import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsbet/app/utils/Core/utils/color.dart';
import 'custom_theme.dart';
import 'color_enum.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  final RxInt selectedThemeIndex = 0.obs;
  final List<ThemeData> themes = [
    CustomTheme(color: AlHilalColorModel.colorModel)
        .buildThemeData(MyColor.alHilal),
    CustomTheme(color: AlNasserColorModel.colorModel)
        .buildThemeData(MyColor.alNasser),
    CustomTheme(color: AlahliColorModel.colorModel)
        .buildThemeData(MyColor.alahli),
    CustomTheme(color: AlTaawonColorModel.colorModel)
        .buildThemeData(MyColor.alTaawon),
    CustomTheme(color: AlIttihadColorModel.colorModel)
        .buildThemeData(MyColor.alIttihad),
    CustomTheme(color: DamacColorModel.colorModel)
        .buildThemeData(MyColor.damak),
    CustomTheme(color: AlFatehColorModel.colorModel)
        .buildThemeData(MyColor.alFateh),
    CustomTheme(color: AlAttifaqColorModel.colorModel)
        .buildThemeData(MyColor.alEttifaq),
    CustomTheme(color: AlWehdaColorModel.colorModel)
        .buildThemeData(MyColor.alWehda),
    CustomTheme(color: AlFihaColorModel.colorModel)
        .buildThemeData(MyColor.alFiha),

    CustomTheme(color: AlShababColorModel.colorModel)
        .buildThemeData(MyColor.alShabab),
    CustomTheme(color: AlTaiColorModel.colorModel)
        .buildThemeData(MyColor.alTai),

   CustomTheme(color: AlKhaleejColorModel.colorModel)
        .buildThemeData(MyColor.alKhaleej),

    CustomTheme(color: AlRiyadhColorModel.colorModel)
        .buildThemeData(MyColor.alRiyadh),
        
    CustomTheme(color: AlRaedColorModel.colorModel)
        .buildThemeData(MyColor.alRaed),

    CustomTheme(color: AlAkhdoudColorModel.colorModel)
        .buildThemeData(MyColor.alAkhdoud),
    CustomTheme(color: AbhaColorModel.colorModel)
        .buildThemeData(MyColor.abha),
    CustomTheme(color: AlHazmColorModel.colorModel)
        .buildThemeData(MyColor.alHazm),
  ];

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  void toggleTheme(int themeIndex) {
    if (selectedThemeIndex.value != themeIndex) {
      selectedThemeIndex.value = themeIndex;
      Get.changeTheme(themes[themeIndex]);
      _saveThemePreference(themeIndex);
    }
  }

  void _saveThemePreference(int themeIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedThemeIndex', themeIndex);
  }

  void _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt('selectedThemeIndex');

    if (themeIndex != null && themeIndex >= 0 && themeIndex < themes.length) {
      selectedThemeIndex.value = themeIndex;
      Get.changeTheme(themes[themeIndex]);
    }
  }
}

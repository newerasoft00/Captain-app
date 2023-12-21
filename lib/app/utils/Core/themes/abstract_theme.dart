import 'package:flutter/material.dart';
import '../../../translations/local_controller.dart';
import '../utils/text_style.dart';
import 'color_enum.dart';

abstract class MyCustomTheme {
  ColorScheme getColorScheme(MyColor color);

  ElevatedButtonThemeData getElevatedButtonThemeData(MyColor color);

  ExpansionTileThemeData getExpansionTileThemeData(MyColor color);

  AppBarTheme getAppBarTheme(MyColor color);

  IconThemeData getIconThemeData(MyColor color);

  ListTileThemeData getListItemThemeData(MyColor color);

  TabBarTheme getTabBarTheme(MyColor color);

  TextButtonThemeData getTextButtonThemeData(MyColor color);

  ButtonThemeData getButtonThemeData(MyColor color);

  CardTheme getCardTheme(MyColor color);

  DividerThemeData getDividerThemeData(MyColor color);

  ThemeData buildThemeData(MyColor color) {
    return ThemeData(
      scaffoldBackgroundColor: getColorScheme(color).background,
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: getColorScheme(color),
      elevatedButtonTheme: getElevatedButtonThemeData(color),
      fontFamilyFallback: [
        MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal'
      ],
      fontFamily:
          MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal',
      expansionTileTheme: getExpansionTileThemeData(color),
      primaryColor: getColorScheme(color).primary,
      primaryColorLight: getColorScheme(color).onPrimary,
      dividerTheme: getDividerThemeData(color),
      appBarTheme: getAppBarTheme(color),
      iconTheme: getIconThemeData(color),
      listTileTheme: getListItemThemeData(color),
      tabBarTheme: getTabBarTheme(color),
      textTheme: CustomTextTheme().getTextTheme(),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 5,
        enableFeedback: true,
        selectedItemColor: getColorScheme(color).primary,
        unselectedItemColor: const Color(0xff9D9D9E),
        selectedLabelStyle: TextStyle(
          color: getColorScheme(color).primary,
        ),
        showUnselectedLabels: true,
      ),
      textButtonTheme: getTextButtonThemeData(color),
      buttonTheme: getButtonThemeData(color),
      cardTheme: getCardTheme(color),
    );
  }
}

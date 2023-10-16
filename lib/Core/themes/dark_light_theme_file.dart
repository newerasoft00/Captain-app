import 'package:flutter/material.dart';

import '../../Local/local_controller.dart';
import '../utils/color.dart';
import '../utils/text_style.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    onPrimary: ColorTeal.onPrimatyColor,
    primary: ColorTeal.primaryColor,
    primaryContainer: ColorTeal.primaryContainer,
    onPrimaryContainer: ColorTeal.onPrimatyContainer,
    error: const Color(0xffBA1A1A),
    tertiary: const Color(0xff466179),
    onTertiary: const Color(0xffFFFFFF),
    tertiaryContainer: const Color(0xffCCE5FF),
    onTertiaryContainer: const Color(0xff001D31),
    background: const Color(0xffFAFDFB),
    onBackground: const Color(0xff191C1B),
    brightness: Brightness.light,
  ),
  fontFamilyFallback: [
    MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal'
  ],
  fontFamily:
      MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal',
  primaryColor: ColorTeal.primaryColor,
  scaffoldBackgroundColor: const Color(0xffFAFDFA),
  secondaryHeaderColor: const Color(0xff605C71),
  primaryColorLight: ColorTeal.onPrimatyColor,
  disabledColor: const Color(0xff9D9D9E),
  dividerColor: const Color.fromARGB(255, 199, 204, 209),
  hintColor: const Color(0xFF9F9F9F),
  dividerTheme: const DividerThemeData(
    color: Color.fromARGB(255, 184, 194, 191),
    indent: 20,
    endIndent: 20,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        color: ColorTeal.onPrimatyColor,
        fontSize: 20,
        fontWeight: FontWeight.w600),
    backgroundColor: ColorTeal.primaryColor,
    scrolledUnderElevation: 0,
  ),
  listTileTheme: ListTileThemeData(
    iconColor: ColorTeal.onPrimatyContainer,
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
    leadingAndTrailingTextStyle: TextStyle(
      color: ColorTeal.onPrimatyContainer,
      fontFamily: 'Roboto',
    ),
  ),
  //

  tabBarTheme: TabBarTheme(
    indicatorColor: ColorTeal.primaryContainer,
    labelStyle: TextStyle(
        color: ColorTealDark.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600),
  ),
  //
  textTheme: CustomTextTheme().getTextTheme(),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 8,
    selectedItemColor: ColorTeal.onPrimatyContainer,
    unselectedItemColor: const Color(0xff9D9D9E), // Unselected icon color
    backgroundColor: Colors.white,
    selectedLabelStyle: const TextStyle(
      color: Colors.white,
    ),
    showUnselectedLabels: true,
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ColorTeal.primaryColor)),
  //
  dialogTheme:
      DialogTheme(titleTextStyle: CustomTextTheme().getTextTheme().bodyLarge),
  dropdownMenuTheme: const DropdownMenuThemeData(
    textStyle: TextStyle(
      color: Colors.red,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      textBaseline: TextBaseline.alphabetic,
    ),
  ),
  //
  canvasColor: Colors.white,
  buttonTheme: ButtonThemeData(
      padding: const EdgeInsets.symmetric(vertical: 10),
      buttonColor: ColorTeal.primaryColor,
      textTheme: ButtonTextTheme.normal,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
  //
  cardColor: ColorTeal.primaryColor,
  cardTheme: CardTheme(
    color: ColorTeal.onPrimatyColor,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  //
);

ThemeData dark = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    onPrimary: ColorTealDark.onPrimaryColor,
    primary: ColorTealDark.primaryColor,
    primaryContainer: ColorTealDark.primaryContainer,
    onPrimaryContainer: ColorTealDark.onPrimaryContainer,
    error: ColorTealDark.error,
    onError: ColorTealDark.onError,
    errorContainer: ColorTealDark.errorContainer,
    tertiary: ColorTealDark.tertiary,
    onTertiary: ColorTealDark.onTertiary,
    tertiaryContainer: ColorTealDark.tertiaryContainer,
    onTertiaryContainer: ColorTealDark.onTertiaryContainer,
    background: const Color(0xff191C1B),
    onBackground: const Color(0xffE0E3E1),
    brightness: Brightness.dark,
  ),
  fontFamilyFallback: [
    MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal'
  ],
  fontFamily:
      MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal',
  primaryColor: ColorTealDark.primaryColor,
  secondaryHeaderColor: const Color(0xff605C71),
  primaryColorLight: ColorTealDark.onPrimaryColor,
  disabledColor: const Color(0xff9D9D9E),
  dividerColor: const Color.fromARGB(255, 199, 204, 209),
  hintColor: const Color(0xFF9F9F9F),
  dividerTheme: const DividerThemeData(
    color: Color(0xff3F4947),
    indent: 20,
    endIndent: 20,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        color: ColorTealDark.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600),
    backgroundColor: const Color(0xff1D2A28),
    scrolledUnderElevation: 0,
    surfaceTintColor: const Color(0xff1D2A28),
    elevation: 0,
  ),
  listTileTheme: ListTileThemeData(
    iconColor: ColorTealDark.onPrimaryContainer,
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
    leadingAndTrailingTextStyle: TextStyle(
      color: ColorTealDark.onPrimaryContainer,
      fontFamily: 'IBMPlexSans-Medium',
    ),
  ),
  //
  dialogTheme: DialogTheme(
      titleTextStyle: CustomTextTheme().getDarkTextTheme().bodyLarge),
  //
  dropdownMenuTheme: const DropdownMenuThemeData(
    textStyle: TextStyle(
      color: Colors.red,
      fontFamily: 'Roboto_regular',
      fontFamilyFallback: ['Roboto'],
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      textBaseline: TextBaseline.alphabetic,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
        color: ColorTealDark.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600),
    indicatorColor: ColorTealDark.primaryColor,
  ),
  //
  textTheme: CustomTextTheme().getDarkTextTheme(),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    selectedItemColor: ColorTealDark.onPrimaryContainer,
    unselectedItemColor: const Color(0xff9D9D9E), // Unselected icon color
    backgroundColor: const Color(0xff1D2A28),
    selectedLabelStyle: const TextStyle(
      color: Colors.white,
    ),
    showUnselectedLabels: true,
  ),

  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ColorTealDark.primaryColor)),
  buttonTheme: ButtonThemeData(
      padding: const EdgeInsets.symmetric(vertical: 10),
      buttonColor: ColorTealDark.primaryColor,
      textTheme: ButtonTextTheme.normal,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
  //
  cardColor: ColorTealDark.primaryContainer,
  cardTheme: CardTheme(
    color: ColorTealDark.onPrimaryColor,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  //
);

ThemeData blueTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    onPrimary: ColorBlue.onPrimaryColor,
    primary: ColorBlue.primaryColor,
    primaryContainer: ColorBlue.primaryContainer,
    onPrimaryContainer: ColorBlue.onPrimaryContainer,
    error: const Color(0xffBA1A1A),
    onError: Colors.white,
    errorContainer: const Color(0xffFFDAD6),
    tertiary: ColorBlue.tertiary,
    onTertiary: ColorBlue.onTertiary,
    tertiaryContainer: ColorBlue.tertiaryContainer,
    onTertiaryContainer: ColorBlue.onTertiaryContainer,
    background: ColorBlue.background,
    onBackground: ColorBlue.onBackground,
    brightness: Brightness.light,
  ),
  fontFamily: 'Roboto',
  primaryColor: ColorBlue.primaryColor,
  secondaryHeaderColor: const Color(0xff605C71),
  primaryColorLight: ColorBlue.onPrimaryColor,
  disabledColor: const Color(0xff9D9D9E),
  dividerColor: const Color.fromARGB(255, 199, 204, 209),
  hintColor: const Color(0xFF9F9F9F),
  dividerTheme: const DividerThemeData(
    color: Color.fromARGB(255, 184, 194, 191),
    indent: 20,
    endIndent: 20,
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
        color: Color(0xffC3C7CF), fontSize: 20, fontWeight: FontWeight.w600),
    backgroundColor: Color(0xff24292F),
    scrolledUnderElevation: 0,
    surfaceTintColor: Color(0xff24292F),
    elevation: 0,
  ),
  listTileTheme: ListTileThemeData(
    iconColor: ColorTealDark.onPrimaryContainer,
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
    leadingAndTrailingTextStyle: TextStyle(
      color: ColorTealDark.onPrimaryContainer,
      fontFamily: 'Roboto',
    ),
  ),

  //
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
        color: ColorBlue.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600),
    indicatorColor: ColorBlue.onPrimaryColor,
  ),
  //
  textTheme: CustomTextTheme().getTextTheme(),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    selectedItemColor: ColorBlue.onPrimaryContainer,
    unselectedItemColor: const Color(0xff9D9D9E), // Unselected icon color
    backgroundColor: const Color(0xff1D2A28),
    selectedLabelStyle: const TextStyle(
      color: Colors.white,
    ),
    showUnselectedLabels: true,
  ),

  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ColorBlue.primaryColor)),
  buttonTheme: ButtonThemeData(
      padding: const EdgeInsets.symmetric(vertical: 10),
      buttonColor: ColorBlue.primaryColor,
      textTheme: ButtonTextTheme.normal,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
  //
  cardColor: ColorBlue.onPrimaryContainer,
  cardTheme: CardTheme(
    color: ColorBlue.onPrimaryColor,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  //
);

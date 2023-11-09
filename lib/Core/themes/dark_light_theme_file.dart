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
    secondaryContainer: ColorTeal.secoundaryContainer,
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
  expansionTileTheme: ExpansionTileThemeData(
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      collapsedBackgroundColor: ColorTeal.secoundaryContainer,
      backgroundColor: ColorTeal.secoundaryContainer,
      textColor: ColorTeal.onPrimatyContainer),
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
    unselectedItemColor: const Color(0xff9D9D9E),
    // Unselected icon color
    backgroundColor: Colors.white,
    selectedLabelStyle: const TextStyle(
      color: Colors.white,
    ),
    showUnselectedLabels: true,
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ColorTeal.primaryColor)),
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
    secondaryContainer: ColorTeal.secoundaryContainer,
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
  expansionTileTheme: ExpansionTileThemeData(
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      collapsedBackgroundColor: ColorTealDark.secoundaryContainer,
      backgroundColor: ColorTealDark.primaryContainer,
      textColor: ColorTealDark.onPrimaryContainer),
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
    unselectedItemColor: const Color(0xff9D9D9E),
    // Unselected icon color
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
    centerTitle: true,
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
    unselectedItemColor: const Color(0xff9D9D9E),
    // Unselected icon color
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
ThemeData redTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    onPrimary: Color(0xFFDB1313),
    primary: Color(0xFFE84646),
    primaryContainer: Color(0xFFFFA2A2),
    onPrimaryContainer: Color(0xFF4C0404),
    secondaryContainer: Color(0xFFFFE1E1),
    error: Color(0xFFBA1A1A),
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    tertiary: Color(0xFF460909),
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFFF7B7B),
    onTertiaryContainer: Color(0xFF4C0404),
    background: Color(0xFFFFF4F4),
    onBackground: Color(0xFF4C0404),
    brightness: Brightness.light,
  ),
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFFE84646),
  scaffoldBackgroundColor: const Color(0xFFFFFAF4),
  secondaryHeaderColor: const Color(0xFF6E4D4D),
  primaryColorLight: Colors.white,
  disabledColor: const Color(0xFF9D9D9E),
  dividerColor: const Color.fromARGB(255, 199, 204, 209),
  hintColor: const Color(0xFF9F9F9F),
  dividerTheme: const DividerThemeData(
    color: Color.fromARGB(255, 184, 194, 191),
    indent: 20,
    endIndent: 20,
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
        color: Color(0xFFE84646), fontSize: 20, fontWeight: FontWeight.w600),
    backgroundColor: Color(0xFFFFA2A2),
    scrolledUnderElevation: 0,
  ),
  listTileTheme: ListTileThemeData(
    iconColor: const Color(0xFF4C0404),
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
    leadingAndTrailingTextStyle: const TextStyle(
      color: Colors.white,
      fontFamily: 'Roboto',
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelStyle: TextStyle(
        color: Color(0xFFE84646), fontSize: 20, fontWeight: FontWeight.w600),
    indicatorColor: Color(0xFFFFA2A2),
  ),
  textTheme: const TextTheme(
      // Define your custom text styles here
      ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 8,
    selectedItemColor: Colors.white,
    unselectedItemColor: Color(0xFF9D9D9E),
    backgroundColor: Colors.white,
    selectedLabelStyle: TextStyle(
      color: Color(0xFFE84646),
    ),
    showUnselectedLabels: true,
  ),
  buttonTheme: const ButtonThemeData(
      padding: EdgeInsets.symmetric(vertical: 10),
      buttonColor: Color(0xFFE84646),
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
  cardColor: const Color(0xFFE84646),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

class BlueMaterial3Theme {
  static ThemeData blueMaterial3Theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF2196F3),
      onPrimary: Colors.white,
      secondary: Color(0xFF64B5F6),
      onSecondary: Colors.white,
      background: Color(0xFFE1F5FE),
      onBackground: Colors.black,
      surface: Color(0xFFE1F5FE),
      onSurface: Colors.black,
      error: Color(0xFFC2185B),
      onError: Colors.white,
      onPrimaryContainer: Colors.white,
      onSecondaryContainer: Colors.white,
      onTertiaryContainer: Colors.black,
    ),
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: const Color(0xFFE1F5FE),
    primaryColor: const Color(0xFF2196F3),
    primaryColorLight: Colors.white,
    disabledColor: const Color(0xFF9D9D9E),
    hintColor: const Color(0xFF9F9F9F),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFC5CAE9),
      indent: 20,
      endIndent: 20,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: Color(0xFF2196F3),
      scrolledUnderElevation: 0,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
      leadingAndTrailingTextStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(
        color: Color(0xFF2196F3),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      indicatorColor: Color(0xFF2196F3),
    ),
    textTheme: const TextTheme(
        // Define your custom text styles here
        ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 8,
      selectedItemColor: Color(0xFF2196F3),
      unselectedItemColor: Color(0xFF9D9D9E),
      backgroundColor: Colors.white,
      selectedLabelStyle: TextStyle(
        color: Color(0xFF2196F3),
      ),
      showUnselectedLabels: true,
    ),
    buttonTheme: const ButtonThemeData(
      padding: EdgeInsets.symmetric(vertical: 10),
      buttonColor: Color(0xFF2196F3),
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    cardColor: const Color(0xFF2196F3),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

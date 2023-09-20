import 'package:flutter/material.dart';
import 'package:sportsbet/res/i_font_res.dart';

const primaryColor = Color(0xff0061A4);
const onPrimatyColor = Color(0xffffffff);
const primaryContainer = Color(0xffD1E4FF);
const whitecolor = Color(0xffffffff);
const blackcolor = Color(0xff000000);
const gray = Color(0xff6B5E5E);
const grayhint = Color(0xffCCC9C9);
const disabledColor = Color(0xFFA0A4A8);
//dark theme color
const darkMaincolor = Color(0xff9ECAFF);
const darkMaincolor2 = Color(0xff003258);
const darkbackground = Color(0xff1A1C1E);
const darktextcolor = Color(0xffE2E2E6);

ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: FontRes.TAJAWAL_MEDIUM,
    primaryColor: primaryColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      unselectedItemColor: disabledColor,
      elevation: 2,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: whitecolor,
    ),
    secondaryHeaderColor: const Color(0xff535F70),
    primaryColorLight: onPrimatyColor,
    disabledColor: const Color(0xFFA0A4A8),
    dividerColor: const Color.fromARGB(255, 199, 204, 209),
    hintColor: const Color(0xFF9F9F9F),
    textTheme: Typography.blackRedwoodCity,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primaryColor)),
    colorScheme: const ColorScheme.light(
            primary: Color(0xff0061A4), secondary: Color(0xff0061A4))
        .copyWith(error: const Color(0xFFE84D4F)),
    buttonTheme: const ButtonThemeData(
        padding: EdgeInsets.symmetric(vertical: 10),
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.normal,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
    cardColor: primaryContainer,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
    ));

ThemeData dark = ThemeData(
    dialogTheme: const DialogTheme(
        backgroundColor: Colors.transparent,
        contentTextStyle: TextField.materialMisspelledTextStyle),
    useMaterial3: false,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      unselectedItemColor: disabledColor,
      elevation: 2,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: whitecolor,
    ),
    scaffoldBackgroundColor: const Color(0xff1A222D),
    fontFamily: FontRes.TAJAWAL_MEDIUM,
    primaryColor: const Color(0xff6585AD),
    primaryColorLight: onPrimatyColor,
    secondaryHeaderColor: const Color(0xff003258),
    disabledColor: const Color(0xFFA0A4A8),
    hintColor: const Color(0xFF9F9F9F),
    textTheme: Typography.whiteMountainView,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: onPrimatyColor)),
    colorScheme: const ColorScheme.light(
            primary: Color(0xff0061A4), secondary: Color(0xff0061A4))
        .copyWith(error: const Color(0xFFE84D4F)),
    buttonTheme: const ButtonThemeData(
        height: 45,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
        buttonColor: Colors.red,
        textTheme: ButtonTextTheme.normal,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        materialTapTargetSize: MaterialTapTargetSize.padded),
    cardColor: const Color(0xff253140),
    cardTheme: CardTheme(
      color: const Color(0xff3E4754),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
    ));

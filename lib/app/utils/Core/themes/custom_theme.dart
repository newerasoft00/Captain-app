import 'package:flutter/material.dart';
import 'abstract_theme.dart';
import 'color_enum.dart';
import 'color_model.dart';

class CustomTheme extends MyCustomTheme {
  final MyColorModel color;

  CustomTheme({required this.color});

  @override
  ColorScheme getColorScheme(MyColor color) {
    return ColorScheme.light(
      onPrimary: this.color.onPrimaryColor,
      secondary: this.color.appBarColor,
      primary: this.color.primaryColor,
      error: const Color(0xffBA1A1A),
      onError: Colors.white,
      onBackground: this.color.onPrimaryContainer,
      brightness: Brightness.light,
    );
  }

  @override
  AppBarTheme getAppBarTheme(MyColor color) {
    return AppBarTheme(
      centerTitle: true,
      backgroundColor: this.color.appBarColor,
      scrolledUnderElevation: 0,
      surfaceTintColor: const Color(0xff24292F),
      elevation: 0,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  ButtonThemeData getButtonThemeData(MyColor color) {
    return ButtonThemeData(
      padding: const EdgeInsets.symmetric(vertical: 10),
      buttonColor: this.color.primaryColor,
      textTheme: ButtonTextTheme.normal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  @override
  CardTheme getCardTheme(MyColor color) {
    return CardTheme(
      color: this.color.cardColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  DividerThemeData getDividerThemeData(MyColor color) {
    return const DividerThemeData(
      color: Color.fromARGB(255, 184, 194, 191),
      indent: 20,
      endIndent: 20,
    );
  }

  @override
  ElevatedButtonThemeData getElevatedButtonThemeData(MyColor color) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: this.color.onPrimaryColor,
        backgroundColor: this.color.appBarColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  ExpansionTileThemeData getExpansionTileThemeData(MyColor color) {
    return ExpansionTileThemeData(
        childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textColor: this.color.primaryColor,
        backgroundColor: this.color.cardColor);
  }

  @override
  IconThemeData getIconThemeData(MyColor color) {
    return IconThemeData(
      color: this.color.onPrimaryColor,
    );
  }

  @override
  ListTileThemeData getListItemThemeData(MyColor color) {
    return ListTileThemeData(
      tileColor: this.color.listTile,
      textColor: this.color.onPrimaryColor,
      iconColor: this.color.onPrimaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      leadingAndTrailingTextStyle: TextStyle(
        color: this.color.onPrimaryColor,
        fontFamily: 'Roboto',
      ),
    );
  }

  @override
  TabBarTheme getTabBarTheme(MyColor color) {
    return TabBarTheme(
      labelStyle: TextStyle(
        color: this.color.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      indicatorColor: this.color.onPrimaryColor,
    );
  }

  @override
  TextButtonThemeData getTextButtonThemeData(MyColor color) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: this.color.primaryColor,
      ),
    );
  }
}

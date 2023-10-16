import 'package:flutter/material.dart';

class CustomTextTheme {
  CustomTextTheme();

  TextTheme getTextTheme() {
    return const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xDD000000),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      bodyMedium: TextStyle(
        color: Color(0xDD000000),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
      ),
      titleLarge: TextStyle(
        color: Color(0x8a000000),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        textBaseline: TextBaseline.alphabetic,
      ),
      headlineSmall: TextStyle(
        color: Color(0x8a000000),
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      headlineMedium: TextStyle(
        color: Color(0x8a000000),
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      displaySmall: TextStyle(
        color: Color(0x8a000000),
        fontSize: 48,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        textBaseline: TextBaseline.alphabetic,
      ),
      displayMedium: TextStyle(
        color: Color(0x8a000000),
        fontSize: 40,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
      ),
      displayLarge: TextStyle(
        color: Color(0x8a000000),
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
      ),
      titleMedium: TextStyle(
        color: Color(0xDD000000),
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        textBaseline: TextBaseline.alphabetic,
      ),
      titleSmall: TextStyle(
        color: Color(0xDD000000),
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        textBaseline: TextBaseline.alphabetic,
      ),
      labelLarge: TextStyle(
        color: Color(0xFF000000),
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      bodySmall: TextStyle(
        color: Color(0xFF000000),
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      labelSmall: TextStyle(
        color: Color(0xFF000000),
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        textBaseline: TextBaseline.alphabetic,
      ),
    );
  }

  TextTheme getDarkTextTheme() {
    return const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        textBaseline: TextBaseline.alphabetic,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 48,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        textBaseline: TextBaseline.alphabetic,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
      ),
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        textBaseline: TextBaseline.alphabetic,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        textBaseline: TextBaseline.alphabetic,
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      labelSmall: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        textBaseline: TextBaseline.alphabetic,
      ),
    );
  }
}

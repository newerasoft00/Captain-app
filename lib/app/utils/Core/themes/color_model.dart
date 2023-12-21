
import 'package:flutter/material.dart';

class MyColorModel {
  final Color primaryColor;
  final Color onPrimaryColor;
  final Color appBarColor;
  final Color cardColor;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color listTile;
  final Color background;
  final Color onBackground;
  final Color textColor;
  final Color surface;
  final Color onSurface;

  MyColorModel({
    required this.onBackground,
    required this.onSurface,
    required this.surface,
    required this.textColor,
    required this.background,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.appBarColor,
    required this.cardColor,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.listTile,
  });
}
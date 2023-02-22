import 'package:flutter/material.dart';

const primaryColor = Color(0xFF006FAD);
const primaryColorLight = Color(0xFF3C98CE);
const primaryColorDark = Color(0xFF144D70);
// final backgroundColor = ColorScheme.light().background;
const backgroundColor = Color(0xFFF8F9FC);
const primaryWhite = Color(0xFFFFFFFF);
final bgLoadingShimmer = Colors.grey.shade300;

const gradientBackground = RadialGradient(
  colors: [
    Color(0xFF3C98CE),
    Color(0xFF2171A1),
    Color(0xFF144D70),
  ],
  center: Alignment.topLeft,
  radius: 1.2,
);

// color
// 0xFF3F6786
// 0xFF193E5C

const bottomButtonLinearGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF0B9CE0),
      Color(0xFF246AB2),
    ]);

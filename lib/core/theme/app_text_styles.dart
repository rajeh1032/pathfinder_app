import 'package:flutter/material.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const fontFamily = 'Cairo';

  static TextStyle displayLarge(Color color) => _style(
        color: color,
        fontSize: 36,
        fontWeight: FontWeight.w800,
      );

  static TextStyle displayMedium(Color color) => _style(
        color: color,
        fontSize: 32,
        fontWeight: FontWeight.w800,
      );

  static TextStyle displaySmall(Color color) => _style(
        color: color,
        fontSize: 28,
        fontWeight: FontWeight.w800,
      );

  static TextStyle headlineLarge(Color color) => _style(
        color: color,
        fontSize: 26,
        fontWeight: FontWeight.w700,
      );

  static TextStyle headlineMedium(Color color) => _style(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );

  static TextStyle headlineSmall(Color color) => _style(
        color: color,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      );

  static TextStyle titleLarge(Color color) => _style(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  static TextStyle titleMedium(Color color) => _style(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

  static TextStyle titleSmall(Color color) => _style(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  static TextStyle bodyLarge(Color color) => _style(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static TextStyle bodyMedium(Color color) => _style(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle bodySmall(Color color) => _style(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle labelLarge(Color color) => _style(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      );

  static TextStyle labelMedium(Color color) => _style(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );

  static TextStyle labelSmall(Color color) => _style(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      );

  static TextStyle button(Color color) => labelLarge(color);

  static TextStyle caption(Color color) => bodySmall(color);

  static TextStyle _style({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return TextStyle(
      color: color,
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}

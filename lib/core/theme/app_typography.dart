import 'package:flutter/material.dart';

class FontFamily {
  static const String lato = 'Lato';
  static const String roboto = 'Roboto';
}

class AppTypography {
  // Default TextTheme with Lato as default
  static TextTheme get textTheme {
    return TextTheme(
      headlineLarge: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.33,
      ),
      bodyLarge: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
      ),
      // Labels use Roboto
      labelLarge: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.45,
      ),
      // Titles use Lato
      titleLarge: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
      ),
      // Display uses Lato
      displayLarge: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontFamily: FontFamily.lato,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 1.22,
      ),
    );
  }
}

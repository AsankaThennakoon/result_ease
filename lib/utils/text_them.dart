import 'package:flutter/material.dart';
import 'package:result_ease/utils/app_colors.dart';

class TextThemeData {
  static TextTheme textTheme = TextTheme(
    bodyText1: const TextStyle(
      color: Colors.black87, // For highly readable body text
    ),
    headline1: const TextStyle(
      color: Color(0xFF1D3557), // For headings or titles
      fontWeight: FontWeight.bold,
      fontSize: 48,
    ),
    bodyMedium: const TextStyle(
      color: AppColors.bodyMediumColor, // For body
      fontWeight: FontWeight.w300,
      fontSize: 20,
    ),
    labelMedium: const TextStyle(
      color: AppColors.labelMediumColor, // for text field
      fontWeight: FontWeight.w300,
      fontSize: 20,
    ),
    button: const TextStyle(
// for button
      fontWeight: FontWeight.w900,
      fontSize: 20,
    ),
  );
}

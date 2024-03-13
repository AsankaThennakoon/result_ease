import 'package:flutter/material.dart';
import 'package:result_ease/utils/app_colors.dart';

class ColorThemeData {
  static final ColorScheme colorScheme = ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(0xFF1D3557, {
      50: Color(0xFFEBF2F7),
      100: Color(0xFFD4E4F1),
      200: Color(0xFFADCBE6),
      300: Color(0xFF85B2D9),
      400: Color(0xFF6094CC),
      500: Color(0xFF457B9D),
      600: Color(0xFF3A688B),
      700: Color(0xFF30577A),
      800: Color(0xFF254568),
      900: Color(0xFF1B3548),
    }),
    brightness: Brightness.light,
    accentColor: AppColors.accentColor, // Use accent color from AppColors
    backgroundColor: AppColors.backgroundColor, // Use background color from AppColors
    cardColor: AppColors.backgroundColorWhite, // Use background color white from AppColors
  );
}

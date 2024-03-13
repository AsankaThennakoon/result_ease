
import 'package:flutter/material.dart';
import 'package:result_ease/utils/app_colors.dart';

class TextThemeData {
  static  TextTheme textTheme = const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black87, // For highly readable body text
    ),
    headline1: TextStyle(
      color: Color(0xFF1D3557), // For headings or titles
      fontWeight: FontWeight.bold,
      fontSize: 48,
    ),
    headline2: TextStyle(
      color: AppColors.buttonColorDark, // For body
      fontWeight: FontWeight.w900,
      fontSize: 24,
    ),
    headline3: TextStyle(
      color: AppColors.backgroundColorWhite, // For body
      fontWeight: FontWeight.w900,
      fontSize: 20,
    ),
    headline4: TextStyle(
      color: AppColors.buttonColorDark, // For body
      fontWeight: FontWeight.w900,
      fontSize: 20,
    ),
    headline5: TextStyle(
      color: AppColors.buttonColorDark, // For body
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),

     headline6: TextStyle(
      color: AppColors.backgroundColorWhite, // For body
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    headlineLarge: TextStyle(
      color: AppColors.backgroundColorWhite, // For body
      fontWeight: FontWeight.w700,
      fontSize: 30,
    ),
    // labelMedium: const TextStyle(
    //   color: AppColors.labelMediumColor, // for text field
    //   fontWeight: FontWeight.w500,
    //   fontSize: 20,
    // ),
    // button: const TextStyle(

    //   fontWeight: FontWeight.w900,// for button
    //   fontSize: 20,
    // ),
  );
}

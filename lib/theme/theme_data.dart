import 'package:flutter/material.dart';

import '../colors/Colors.dart';

ThemeData lightMode = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackgroundColor
    ),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: AppColors.lightBackgroundColor,
        primary: AppColors.lightPrimaryColor,
        secondary: AppColors.lightSecondaryColor,
        surface: Colors.black
    )
);

ThemeData darkMode = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackgroundColor
    ),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: AppColors.darkBackgroundColor,
        primary: AppColors.darkPrimaryColor,
        secondary: AppColors.darkSecondaryColor,
        surface: Colors.white,
    ),
);
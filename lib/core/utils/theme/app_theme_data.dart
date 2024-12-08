import 'package:flutter/material.dart';
import 'package:food_app/core/utils/theme/app_color_scheme.dart';
import 'package:food_app/core/utils/theme/bottom_nav_bar_theme.dart';
import 'package:food_app/core/utils/theme/input_decoration_theme.dart';
import 'package:food_app/core/utils/theme/text_theme.dart';

import 'app_theme.dart';

extension AppThemeData on AppTheme {
  ThemeData get themeData {
    return ThemeData(
        fontFamily: "BentonSans",
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
         textTheme: textThemeData,
        // appBarTheme: appBarThemeData,
        bottomNavigationBarTheme: bottomNavBarTheme,
         inputDecorationTheme: inputDecorationThemeData,
        // textButtonTheme: textButtonThemeData,
      );
  }
}

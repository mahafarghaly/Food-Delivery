import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/app.dart';
import 'package:food_app/core/utils/theme/app_color_scheme.dart';
import 'package:food_app/core/utils/theme/text_theme.dart';

import 'app_theme.dart';

extension AppInputDecorationThemeData on AppTheme {
  InputDecorationTheme get inputDecorationThemeData {
    return InputDecorationTheme(
      labelStyle: textThemeData.bodyLarge?.copyWith(
        color: colorScheme.onSurface,
      ),
      floatingLabelStyle: textThemeData.bodySmall?.copyWith(
        color: colorScheme.primary,
      ),
        border: InputBorder.none,
      hintStyle: textThemeData.bodySmall?.copyWith(
        color: colorScheme.onPrimaryContainer.withOpacity(0.4),


      )

    );
  }
}

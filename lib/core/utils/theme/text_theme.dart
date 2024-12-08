import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/utils/theme/app_color_scheme.dart';
import 'package:food_app/core/utils/theme/app_theme.dart';

extension AppTextTheme on AppTheme{
  TextTheme get textThemeData{
    return TextTheme(
        headlineLarge: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface),
        headlineMedium: TextStyle(
            fontSize: 31.sp,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface),
        headlineSmall: TextStyle(
            fontSize: 27.sp,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface),
        titleLarge: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface),
        titleMedium: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface),
        titleSmall: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface),
        bodyLarge: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface),
        bodyMedium: TextStyle(
          fontFamily: "BentonSans Medium",
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
        ),
        bodySmall: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface),
      labelLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface),
      labelMedium: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface),
      labelSmall: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          fontFamily: "BentonSans Book",
          color: colorScheme.onSurface),
    );





  }
}
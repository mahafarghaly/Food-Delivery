import 'package:flutter/material.dart';
import 'app_theme.dart';
extension AppColorScheme on AppTheme {
  ColorScheme get colorScheme {
    switch (this) {
      case AppTheme.light:
        return _lightColorScheme;
      case AppTheme.dark:
        return _darkColorScheme;
    }
  }
  ColorScheme get _lightColorScheme => const ColorScheme(
  brightness: Brightness.light,
    primary:  Color(0xff15BE77),
    onPrimary:  Color(0xffFFFFFF),
    secondary: Color(0xff53E88B),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFBA1A1A),
    onError: Color(0xffFF4545),
    surface: Color(0xFFFEFEFF),
    onSurface: Color(0xFF191C20),
    onPrimaryContainer: Color(0xffDA6317),
    primaryContainer:Color(0xffF9A84D),
    scrim: Color(0xffFF7C32),
    surfaceDim: Color(0xff000000),
    outlineVariant: Color(0xff3B3B3B),
    onTertiaryContainer: Color(0xffFEAD1D),





  );
  ColorScheme get _darkColorScheme => const ColorScheme(
    brightness: Brightness.dark,
    primary:  Color(0xff15BE77),
    onPrimary:  Color(0xffFFFFFF),
    secondary: Color(0xff15BE77),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFF111318),
    onSurface: Color(0xFFE1E2E9),
    onPrimaryContainer: Color(0xffDA6317),
    primaryContainer:Color(0xffF9A84D),
    scrim: Color(0xffFF7C32),
    surfaceDim: Color(0xffFFFFFF),
      outlineVariant: Color(0xFFFFFFFF),
    onTertiaryContainer: Color(0xffFEAD1D),
  );



}


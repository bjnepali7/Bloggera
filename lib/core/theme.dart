import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border({Color color = AppPallete.borderColor}) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 3),
    borderRadius: BorderRadius.circular(8),
  );

  static final darkModeTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(24),
      enabledBorder: _border(),

      focusedBorder: _border(color: AppPallete.gradient2),
      errorBorder: _border(color: AppPallete.errorColor),
      focusedErrorBorder: _border(color: AppPallete.errorColor),
    ),
  );
}

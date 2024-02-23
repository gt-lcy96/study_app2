import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_app_2/configs/themes/app_colors.dart';

mixin SubThemeData {
  TextTheme getTextTheme() {
    return GoogleFonts.quicksandTextTheme(const TextTheme(
      bodyText1: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      bodyText2: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ));
  }

  IconThemeData getIconTheme() {
    return const IconThemeData(color: onSurfaceTextColor, size: 18);
  }
}

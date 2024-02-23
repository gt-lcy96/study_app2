import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_app_2/configs/themes/sub_theme_data_mixin.dart';

// const Color primaryDarkColorDark = Color(0xFF2e3c62);
// const Color primaryColorDark = Color(0xFF99ace1);
const Color primaryDarkColorDark = Color.fromARGB(255, 46, 52, 98);
const Color primaryColorDark = Color.fromARGB(255, 153, 179, 225);
const Color mainTextColorDark = Colors.white;

class DarkTheme with SubThemeData {
  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
        iconTheme: getIconTheme(),
        textTheme: getTextTheme().apply(
          bodyColor: mainTextColorDark,
          displayColor: mainTextColorDark,
        ));
  }
}

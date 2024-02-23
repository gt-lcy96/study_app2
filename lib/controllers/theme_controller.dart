import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/app_dark_theme.dart';
import 'package:study_app_2/configs/themes/app_light_theme.dart';

class ThemeController extends GetxController {
  bool _isLightMode = true;
  bool get isLightMode => _isLightMode;
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;

  @override
  void onInit() {
    initializeThemeData();
    super.onInit();
  }

  initializeThemeData() {
    _darkTheme = DarkTheme().buildDarkTheme();
    _lightTheme = LightTheme().buildLightTheme();
  }

  toggleDarkmode() {
    _isLightMode = !_isLightMode; // Toggle the theme mode
    Get.changeTheme(_isLightMode ? _lightTheme : _darkTheme);
    update();
  }
}
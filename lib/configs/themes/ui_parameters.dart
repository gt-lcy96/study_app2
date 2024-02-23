import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _mobileScreenPadding = 24.0;
const double _cardBorderRadius = 12.0;
double get mobileScreenPadding => _mobileScreenPadding;
double get cardBorderRadius => _cardBorderRadius;

class UIParameters {
  static BorderRadius get cardBorderRadius => BorderRadius.circular(_cardBorderRadius);
  static EdgeInsets get mobileScreenPadding => const EdgeInsets.all(_mobileScreenPadding);
  static bool isDarkMode() {
    return Get.isDarkMode;
  }
}
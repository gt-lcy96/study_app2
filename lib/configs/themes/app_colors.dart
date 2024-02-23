import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/ui_parameters.dart';
import 'package:study_app_2/controllers/theme_controller.dart';

import 'app_light_theme.dart';
import 'app_dark_theme.dart';
import 'package:flutter/material.dart';

const Color onSurfaceTextColor = Colors.white;
const Color correctAnswerColor = Color(0xFF3ac3cb);
const Color wrongAnswerColor = Color(0xFFf85187);
// const Color notAnsweredColor = Color(0xFF2a3c65);
// Color notAnsweredColor = Get.find<ThemeController>().isLightMode ?  Color(0xFF2a3c65) : Colors.white;
// Color notAnsweredColor = Get.find<ThemeController>().isLightMode ?  Color.fromARGB(255, 38, 80, 176) : Colors.white;
Color notAnsweredColor = Get.find<ThemeController>().isLightMode ?  Colors.white : Color.fromARGB(255, 38, 80, 176);
// Theme.of(Get.context!).cardColor
// Color notAnsweredColor = Theme.of(Get.context!).cardColor;

const mainGradientLight = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [primaryLightColorLight, primaryColorLight]);

const mainGradientDark = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [primaryDarkColorDark, primaryColorDark]);


LinearGradient mainGradient() => Get.find<ThemeController>().isLightMode
    ? mainGradientLight
    : mainGradientDark;

Color customScaffoldColor(BuildContext context) =>
    Get.find<ThemeController>().isLightMode
        ? const Color.fromARGB(255, 240, 237, 255)
        : const Color(0xFF2e3c62);

// ? const Color.fromARGB(255, 20, 46, 158)
// : const Color.fromARGB(255, 221, 221, 221);

Color answerSelectedColor() => Get.find<ThemeController>().isLightMode
    ? Theme.of(Get.context!).primaryColor
    : Theme.of(Get.context!).cardColor.withOpacity(0.5);

Color answerBorderColor() => Get.find<ThemeController>().isLightMode
    ? const Color.fromARGB(255, 221, 221, 221)
    : const Color.fromARGB(255, 20, 46, 158);

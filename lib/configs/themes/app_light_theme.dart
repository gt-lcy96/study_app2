import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_app_2/configs/themes/sub_theme_data_mixin.dart';

// const Color primaryLightColorLight = Color(0xFF3ac3cb);
// const Color primaryColorLight = Color(0xFFf85187);
const Color primaryLightColorLight = Color.fromARGB(255, 58, 203, 176);
const Color primaryColorLight = Color.fromARGB(255, 248, 81, 165);

// const Color mainTextColor = Color.fromARGB(255, 40, 40, 40);
// const Color mainTextColorLight = Color.fromARGB(255, 195, 195, 195);
const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);

class LightTheme with SubThemeData {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      primaryColor: primaryColorLight,
      iconTheme: getIconTheme(),
      cardColor: cardColor,
      textTheme: getTextTheme().apply(
        bodyColor: mainTextColorLight,
        displayColor: mainTextColorLight,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/app_colors.dart';
import 'package:study_app_2/pages/splash_screen/controller.dart';

class SplashScreenPage extends GetView<SplashScreenController> {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Image.asset(
        "assets/images/book_logo_prev_ui.png",
        width: 250.w,
        height: 250.h,
      ),
    ));
  }
}

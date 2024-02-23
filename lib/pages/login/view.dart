import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/app_colors.dart';
import 'package:study_app_2/controllers/auth_controller.dart';
import 'package:study_app_2/controllers/theme_controller.dart';
import 'package:study_app_2/widgets/common/main_button.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/book_logo_prev_ui.png",
            width: 250,
            height: 250,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 65.h),
            child: const Text(
              "This is a study app, There will be a few question for you to answer in the quiz. If you are developer, you can try to understand the code and scale it",
              style: TextStyle(
                color: onSurfaceTextColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          MainButton(
            onTap: () {
              controller.signInWithGoogle();
            },
            child: Stack(children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: SvgPicture.asset("assets/icons/google.svg"),
              ),
              Center(
                child: Text(
                  "Sign in with Google",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    ));
  }
}

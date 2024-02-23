import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app_2/configs/themes/app_colors.dart';
import 'package:study_app_2/routes/routes.dart';
import 'package:study_app_2/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.book,
              size: 65.sp,
            ),
            SizedBox(height: 40.h),
            const Text(
              'This is a study app, There will be a few question for you to answer in the quiz. If you are developer, you can try to understand the code and scale it',
              style: TextStyle(
                fontSize: 18,
                color: onSurfaceTextColor,
              ),
            ),
            SizedBox(height: 40.h),
            AppCircleButton(
                onTap: () {
                  print("tap AppCircleButton");
                  Get.toNamed(AppRoutes.HOME);
                },
                child: const Icon(Icons.arrow_forward_outlined, size: 35)),
          ]),
        ),
      ),
    );
  }
}

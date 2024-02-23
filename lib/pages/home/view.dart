import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/app_colors.dart';
import 'package:study_app_2/configs/themes/app_icons.dart';
import 'package:study_app_2/configs/themes/custom_textStyle.dart';
import 'package:study_app_2/configs/themes/ui_parameters.dart';
import 'package:study_app_2/controllers/question_paper_controller.dart';
import 'package:study_app_2/controllers/theme_controller.dart';
import 'package:study_app_2/controllers/zoom_drawer_controller.dart';
import 'package:study_app_2/pages/home/widgets/menu_screen.dart';
import 'package:study_app_2/pages/home/widgets/question_card.dart';
import 'package:study_app_2/widgets/app_circle_button.dart';
import 'package:study_app_2/widgets/content_area.dart';

class HomePage extends GetView<MyZoomDrawerController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionPaperController _questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(
        builder: (_) {
          return ZoomDrawer(
            controller: _.zoomDrawerController,
            showShadow: true,
            angle: 0.0,
            style: DrawerStyle.DefaultStyle,
            backgroundColor: Colors.white.withOpacity(0.5),
            slideWidth: Get.width * 0.6,
            menuScreen: MenuScreen(),
            mainScreen: GetBuilder<ThemeController>(builder: (themeController) {
              return Container(
                decoration: BoxDecoration(gradient: mainGradient()),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(mobileScreenPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCircleButton(
                                onTap: controller.toggleDrawer,
                                child: Icon(
                                  Icons.menu,
                                  size: 20.sp,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  Icon(AppIcons.peace),
                                  Text("Hello",
                                      style: detailText.copyWith(
                                        color: onSurfaceTextColor,
                                      ))
                                ],
                              ),
                            ),
                            Text("Test yourself today for skill improvement",
                                style: headerText),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ContentArea(
                            addPadding: false,
                            child: Obx(
                              () => ListView.separated(
                                padding: UIParameters.mobileScreenPadding,
                                itemBuilder: (BuildContext context, int index) {
                                  // print("_questionPaperController.allPapers[index].image_url!:  ${_questionPaperController.allPapers[index].image_url!}");
                                  return QuestionCard(
                                      model: _questionPaperController
                                          .allPapers[index]);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height: 20.h,
                                ),
                                itemCount:
                                    _questionPaperController.allPapers.length,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

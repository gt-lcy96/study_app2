import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/app_colors.dart';
import 'package:study_app_2/configs/themes/custom_textStyle.dart';
import 'package:study_app_2/configs/themes/ui_parameters.dart';
import 'package:study_app_2/firebase_ref/loading_status.dart';
import 'package:study_app_2/pages/question/controller.dart';
import 'package:study_app_2/routes/routes.dart';
import 'package:study_app_2/widgets/common/background_decoration.dart';
import 'package:study_app_2/widgets/common/custom_app_bar.dart';
import 'package:study_app_2/widgets/common/main_button.dart';
import 'package:study_app_2/widgets/common/question_place_holder.dart';
import 'package:study_app_2/widgets/content_area.dart';
import 'package:study_app_2/widgets/questions/answer_card.dart';
import 'package:study_app_2/widgets/questions/countdown_timer.dart';

class QuestionPage extends GetView<QuestionController> {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
          leading: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: const ShapeDecoration(
              shape: StadiumBorder(
                side: BorderSide(color: onSurfaceTextColor, width: 2),
              ),
            ),
            child: Obx(
              () => CountDownTimer(
                  time: controller.time.value, color: onSurfaceTextColor),
            ),
          ),
          showActionIcon: true,
          titleWidget: Obx(
            () => Text(
                "Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}",
                style: appBarTS),
          )),
      body: BackgroundDecoration(
        showGradient: true,
        child: Obx(() => Container(
              // height: Get.height,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (controller.loadingStatus == LoadingStatus.completed)
                      ? Expanded(
                          child: ContentArea(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(top: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.currentQuestion.value!.question,
                                  style: questionText,
                                ),
                                GetBuilder<QuestionController>(
                                    id: 'answers_list',
                                    builder: (context) {
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(top: 25.h),
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final answer = controller
                                              .currentQuestion
                                              .value!
                                              .answers[index];
                                          return AnswerCard(
                                            answer:
                                                '${answer.identifier}. ${answer.answer}',
                                            onTap: () {
                                              controller.selectedAnswer(
                                                  answer.identifier);
                                            },
                                            isSelected: answer.identifier ==
                                                controller.currentQuestion
                                                    .value!.selectedAnswer,
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                SizedBox(
                                          height: 10.h,
                                        ),
                                        itemCount: controller.currentQuestion
                                            .value!.answers.length,
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ))
                      : Expanded(
                          child: ContentArea(child: QuestionScreenHolder())),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                        padding: UIParameters.mobileScreenPadding,
                        child: Row(children: [
                          Visibility(
                            visible: controller.isNotFirstQuestion,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: SizedBox(
                                  width: 55.w,
                                  height: 55.h,
                                  child: MainButton(
                                      onTap: () {
                                        controller.prevQuestion();
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Get.isDarkMode
                                            ? onSurfaceTextColor
                                            : Theme.of(context).primaryColor,
                                      ))),
                            ),
                          ),
                          Expanded(
                            child: Visibility(
                              visible: controller.loadingStatus.value ==
                                  LoadingStatus.completed,
                              child: MainButton(
                                onTap: () {
                                  controller.isLastQuestion
                                      ? Get.toNamed(AppRoutes.TEST_OVERVIEW)
                                      : controller.nextQuestion();
                                },
                                title: controller.isLastQuestion
                                    ? 'Complete'
                                    : 'Next',
                              ),
                            ),
                          )
                        ])),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/custom_textStyle.dart';
import 'package:study_app_2/configs/themes/ui_parameters.dart';
import 'package:study_app_2/pages/home/widgets/question_card.dart';
import 'package:study_app_2/pages/question/index.dart';
import 'package:study_app_2/widgets/common/background_decoration.dart';
import 'package:study_app_2/widgets/common/custom_app_bar.dart';
import 'package:study_app_2/widgets/common/main_button.dart';
import 'package:study_app_2/widgets/content_area.dart';
import 'package:study_app_2/widgets/questions/answer_card.dart';
import 'package:study_app_2/widgets/questions/countdown_timer.dart';
import 'package:study_app_2/widgets/questions/question_number_card.dart';

class TestOverviewPage extends GetView<QuestionController> {
  const TestOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: controller.completeTest,
        ),
        body: BackgroundDecoration(
          showGradient: true,
          child: Column(children: [
            Expanded(
              child: ContentArea(
                  child: Column(
                children: [
                  Row(
                    children: [
                      CountDownTimer(
                        color: UIParameters.isDarkMode()
                            ? Theme.of(context).textTheme.bodyText1!.color
                            : Theme.of(context).primaryColor,
                        time: '',
                      ),
                      Obx(() => Text(
                            '${controller.time} Remaining',
                            style: countDownTimerTS(),
                          )),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: GridView.builder(
                        itemCount: controller.allQuestion.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_, index) {
                          AnswerStatus? _answerStatus;
                          if (controller.allQuestion[index].selectedAnswer !=
                              null) {
                            _answerStatus = AnswerStatus.answered;
                          }

                          return QuestionNumberCard(
                            index: index + 1,
                            status: _answerStatus,
                            onTap: ()=> controller.jumpToQuestion(index),
                          );
                        }),
                  ),
                ],
              )),
            ),
            ColoredBox(color: Theme.of(context).scaffoldBackgroundColor, child: Padding(
              padding: UIParameters.mobileScreenPadding,
              child: MainButton(
                onTap: (){
                  controller.complete();
                },
                title: 'Complete',
              ),
            )),
          ]),
        ));
  }
}

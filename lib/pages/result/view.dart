import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/app_light_theme.dart';
import 'package:study_app_2/configs/themes/custom_textStyle.dart';
import 'package:study_app_2/configs/themes/ui_parameters.dart';
import 'package:study_app_2/controllers/questions_controller_extension.dart';
import 'package:study_app_2/pages/question/index.dart';
import 'package:study_app_2/routes/routes.dart';
import 'package:study_app_2/widgets/common/background_decoration.dart';
import 'package:study_app_2/widgets/common/custom_app_bar.dart';
import 'package:study_app_2/widgets/common/main_button.dart';
import 'package:study_app_2/widgets/content_area.dart';
import 'package:study_app_2/widgets/questions/answer_card.dart';
import 'package:study_app_2/widgets/questions/question_number_card.dart';

class ResultPage extends GetView<QuestionController> {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color _textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: SizedBox(height: 80.h),
        title: controller.correctAnsweredQuestions,
      ),
      body: BackgroundDecoration(
        showGradient: true,
        child: Column(
          children: [
            Expanded(
                child: ContentArea(
              child: Column(
                children: [
                  Image.asset('assets/images/bulb_logo-removebg-preview.png', width: 100, height: 100,),

                  Padding(
                    padding: EdgeInsets.only(top: 25.h, bottom: 5.h),
                    child: Text('Congratulations',
                        style: headerText.copyWith(color: primaryLightColorLight)),
                  ),
                  Text(
                    'You have ${controller.points} points',
                    style: TextStyle(color: primaryLightColorLight),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    'Tap below question numbers to view correct answer',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: controller.allQuestion.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_, index) {
                          final _question = controller.allQuestion[index];
                          AnswerStatus _status = AnswerStatus.notAnswered;
                          final _selectedAnswer = _question.selectedAnswer;
                          final _correctAnswer = _question.correctAnswer;

                          if (_selectedAnswer == _correctAnswer) {
                            _status = AnswerStatus.correct;
                          } else if (_question.selectedAnswer == null) {
                            _status = AnswerStatus.wrong;
                          } else {
                            _status = AnswerStatus.wrong;
                          }

                          return QuestionNumberCard(
                            index: index + 1,
                            status: _status,
                            onTap: () {
                              controller.jumpToQuestion(index, isGoBack: false);
                              Get.toNamed(AppRoutes.ANSWER_CHECK);
                            },
                          );
                        }),
                  )
                ],
              ),
            )),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(children: [
                    Expanded(
                      child: MainButton(
                          onTap: () {
                            controller.tryAgain();
                          },
                          color: Colors.blueGrey,
                          title: 'Try Again'),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: MainButton(
                          onTap: () {
                            controller.saveTestResults();
                          },
                          title: 'Go Home'),
                    ),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/custom_textStyle.dart';
import 'package:study_app_2/controllers/theme_controller.dart';
import 'package:study_app_2/pages/question/index.dart';
import 'package:study_app_2/routes/routes.dart';
import 'package:study_app_2/widgets/common/background_decoration.dart';
import 'package:study_app_2/widgets/common/custom_app_bar.dart';
import 'package:study_app_2/widgets/content_area.dart';
import 'package:study_app_2/widgets/questions/answer_card.dart';

class AnswerCheckPage extends GetView<QuestionController> {
  const AnswerCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}',
            style: appBarTS,
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(AppRoutes.RESULT);
        },
      ),
      body: BackgroundDecoration(
        showGradient: true,
        child: Obx(() => Column(
              children: [
                Expanded(
                    child: ContentArea(
                        child: SingleChildScrollView(
                            padding: EdgeInsets.only(top: 20),
                            child: Column(children: [
                              Text(controller.currentQuestion.value!.question),
                              GetBuilder<ThemeController>(builder: (_) {
                                return GetBuilder<QuestionController>(
                                    id: 'answer_review_list',
                                    builder: (_) {
                                      return ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (_, index) {
                                            final answer = controller
                                                .currentQuestion
                                                .value!
                                                .answers[index];
                                            controller.currentQuestion.value!
                                                .selectedAnswer;
                                            final selectedAnswer = controller
                                                .currentQuestion
                                                .value!
                                                .selectedAnswer;
                                            final correctAnswer = controller
                                                .currentQuestion
                                                .value!
                                                .correctAnswer;
                                            final String answerText =
                                                '${answer.identifier}. ${answer.answer}';
                                            if (correctAnswer ==
                                                    selectedAnswer &&
                                                answer.identifier ==
                                                    selectedAnswer) {
                                              return CorrectAnswer(
                                                  answer: answerText);
                                            } else if (selectedAnswer == null) {
                                              return NotAnswer(
                                                  answer: answerText);
                                            } else if (correctAnswer !=
                                                    selectedAnswer &&
                                                answer.identifier ==
                                                    selectedAnswer) {
                                              return WrongAnswer(
                                                  answer: answerText);
                                            } else if (correctAnswer ==
                                                answer.identifier) {
                                              return CorrectAnswer(
                                                  answer: answerText);
                                            }

                                            return AnswerCard(
                                              answer: answerText,
                                              onTap: () {},
                                              isSelected: false,
                                            );
                                          },
                                          separatorBuilder: (_, index) {
                                            return SizedBox(height: 10.h);
                                          },
                                          itemCount: controller.currentQuestion
                                              .value!.answers.length);
                                    });
                              }),
                            ])))),
              ],
            )),
      ),
    );
  }
}

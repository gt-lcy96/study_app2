import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/app_colors.dart';
import 'package:study_app_2/configs/themes/ui_parameters.dart';
import 'package:study_app_2/controllers/theme_controller.dart';

enum AnswerStatus { correct, wrong, answered, notAnswered }

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerCard({
    super.key,
    required this.answer,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
          child: Text(
            answer,
            style: TextStyle(
              color: isSelected ? onSurfaceTextColor : null,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: UIParameters.cardBorderRadius,
              color: isSelected
                  ? answerSelectedColor()
                  : Theme.of(context).cardColor,
              border: Border.all(
                color: isSelected ? answerSelectedColor() : answerBorderColor(),
              ))),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({
    super.key,
    required this.answer,
  });
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: correctAnswerColor.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(answer,
          style: const TextStyle(
            color: correctAnswerColor,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({
    super.key,
    required this.answer,
  });
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: wrongAnswerColor.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(answer,
          style: const TextStyle(
            color: wrongAnswerColor,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}

class NotAnswer extends StatelessWidget {
  const NotAnswer({
    super.key,
    required this.answer,
  });
  final String answer;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return Ink(
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: themeController.isLightMode ? Colors.white : Theme.of(context).cardColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(answer,
            style: TextStyle(
              color: themeController.isLightMode
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold,
            )),
      );
    });
  }
}

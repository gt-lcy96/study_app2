import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/app_icons.dart';
import 'package:study_app_2/configs/themes/custom_textStyle.dart';
import 'package:study_app_2/configs/themes/ui_parameters.dart';
import 'package:study_app_2/controllers/question_paper_controller.dart';
import 'package:study_app_2/controllers/theme_controller.dart';
import 'package:study_app_2/models/question_paper_model.dart';
import 'package:study_app_2/widgets/app_icon_text.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  const QuestionCard({super.key, required this.model});
  final QuestionPaperModel model;

  @override
  Widget build(BuildContext context) {
    var iconColor = Get.find<ThemeController>().isLightMode
        ? Theme.of(context).primaryColor
        : Colors.white;

    var descriptionTextColor = Get.find<ThemeController>().isLightMode
        ? Colors.black
        : Colors.white;

    const double _padding = 10.0;
    return GetBuilder<ThemeController>(builder: (builder) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: Theme.of(context).cardColor),
        child: InkWell(
          onTap: () {
            controller.navigateToQuestions(paper: model, tryAgain: false);
            // print('${model.title}');
            print("model.title:  ${model.title}");
          },
          child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        child: FadeInImage(
                          image: NetworkImage(model.image_url!),
                          placeholder:
                              AssetImage("assets/images/book_logo_prev_ui.png"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    // '''jump'''
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title!,
                          style: cartTitles(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(
                            model.description!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: descriptionTextColor,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            AppIconText(
                                icon: Icon(Icons.help_outline_sharp,
                                    color: iconColor),
                                text: Text('${model.questionCount} questions',
                                    style:
                                        detailText.copyWith(color: iconColor))),
                            SizedBox(
                              width: 15,
                            ),
                            AppIconText(
                                icon: Icon(Icons.timer, color: iconColor),
                                text: Text('${model.timeInMinits()}',
                                    style:
                                        detailText.copyWith(color: iconColor))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
                Positioned(
                    bottom: -_padding,
                    right: -_padding,
                    child: GestureDetector(
                        child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 20.w),
                      child: Icon(
                        AppIcons.trophyOutline,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(cardBorderRadius),
                            bottomRight: Radius.circular(cardBorderRadius),
                          ),
                          color: Theme.of(context).primaryColor),
                    )))
              ],
            ),
          ),
        ),
      );
    });
  }
}

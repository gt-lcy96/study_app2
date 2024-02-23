import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:study_app_2/controllers/auth_controller.dart';
import 'package:study_app_2/controllers/question_paper_controller.dart';
import 'package:study_app_2/firebase_ref/loading_status.dart';
import 'package:study_app_2/firebase_ref/references.dart';
import 'package:study_app_2/models/question_paper_model.dart';
import 'package:study_app_2/routes/routes.dart';

class QuestionController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionPaperModel questionPaperModel;
  final allQuestion = <QuestionModel>[];
  final questionIndex = 0.obs;
  bool get isNotFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestion.length - 1;

  Rxn<QuestionModel> currentQuestion = Rxn<QuestionModel>();

  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    final _questionPaper = Get.arguments as QuestionPaperModel;
    loadData(_questionPaper);
    print("_questionPaper.title:  ${_questionPaper.title}");
  }

  Future<void> loadData(QuestionPaperModel questionPaper) async {
    loadingStatus.value = LoadingStatus.loading;
    update();
    questionPaperModel = questionPaper;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF
              .doc(questionPaperModel.id)
              .collection("questions")
              .get();
      final questions = questionQuery.docs
          .map((snapshot) => QuestionModel.fromSnapshot(snapshot))
          .toList();
      questionPaperModel.questions = questions;
      for (QuestionModel _question in questionPaperModel.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection("questions")
                .doc(_question.id)
                .collection("answers")
                .get();
        final answers = answersQuery.docs
            .map((answer) => AnswerModel.fromSnapshot(answer))
            .toList();
        _question.answers = answers;
      }

      if (questionPaperModel.questions != null &&
          questionPaperModel.questions!.isNotEmpty) {
        allQuestion.assignAll(questionPaperModel.questions!);
        currentQuestion.value = questionPaperModel.questions![0];
        _startTimer(questionPaper.time_seconds!);
        loadingStatus.value = LoadingStatus.completed;
        update();
      } else {
        loadingStatus.value = LoadingStatus.error;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list', 'answer_review_list']);
  }

  String get completeTest {
    final answered = allQuestion
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;

    return "$answered out of ${allQuestion.length} answered";
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestion[index];
    if (isGoBack) {
      Get.back();
    }
  }

  void nextQuestion() {
    // dont have next question any more
    if (questionIndex.value >= allQuestion.length - 1) {
      return;
    }

    questionIndex.value++;
    currentQuestion.value = allQuestion[questionIndex.value];
  }

  void prevQuestion() {
    // dont have previous question any more
    if (questionIndex.value <= 0) {
      return;
    }

    questionIndex.value--;
    currentQuestion.value = allQuestion[questionIndex.value];
  }

  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        remainSeconds--;
      }
    });
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(AppRoutes.RESULT);
  }

  void tryAgain() {
    // reset question to question 1
    questionIndex.value = 0;
    currentQuestion.value = allQuestion[0];

    Get.find<QuestionPaperController>()
        .navigateToQuestions(paper: questionPaperModel, tryAgain: true);
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(AppRoutes.HOME, (route) => false);
  }
}

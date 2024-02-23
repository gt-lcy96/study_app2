import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:study_app_2/controllers/auth_controller.dart';
import 'package:study_app_2/firebase_ref/references.dart';
import 'package:study_app_2/pages/question/index.dart';

extension QuestionsControllerExtension on QuestionController {
  int get correctQuestionCount => allQuestion
      .where((e) => e.selectedAnswer == e.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount out of ${allQuestion.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestion.length) *
        100 *
        (questionPaperModel.time_seconds! - remainSeconds) /
        questionPaperModel.time_seconds! *
        100;
    return points.toStringAsFixed(2);
  }

  // save result to firebase
  Future<void> saveTestResults() async {
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;
    batch.set(
      userRF
          .doc(_user.email)
          .collection('recent_test_results')
          .doc(questionPaperModel.id),
        {
          'points': points,
          'correct_answer': '$correctQuestionCount/${allQuestion.length}',
          'question_id': questionPaperModel.id,
          'time': questionPaperModel.time_seconds! - remainSeconds,
        }
    );
    batch.commit();
    navigateToHome();
  }
}

import 'package:get/get.dart';
import 'package:study_app_2/pages/question/controller.dart';

class QuestionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<QuestionController>(QuestionController());
  }

}
import 'package:get/get.dart';
import 'package:study_app_2/pages/splash_screen/controller.dart';

class SplashScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController);
  }
}
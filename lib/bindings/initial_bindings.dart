import 'package:get/get.dart';
import 'package:study_app_2/controllers/auth_controller.dart';
import 'package:study_app_2/controllers/theme_controller.dart';
import 'package:study_app_2/services/firebase_storage_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    Get.put(FirebaseStorageService());
  }

}
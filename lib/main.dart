import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:study_app_2/bindings/initial_bindings.dart';
import 'package:study_app_2/configs/themes/app_dark_theme.dart';
import 'package:study_app_2/configs/themes/app_light_theme.dart';
import 'package:study_app_2/controllers/theme_controller.dart';
import 'package:study_app_2/firebase_options.dart';
import 'package:study_app_2/pages/data_uploader/view.dart';
import 'package:study_app_2/pages/introduction/view.dart';
import 'package:study_app_2/routes/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        child: GetMaterialApp(
      theme: Get.find<ThemeController>().lightTheme,
      darkTheme: Get.find<ThemeController>().darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // home: IntroductionPage(),
      // home: DataUploaderScreen(),
    ));
  }
}
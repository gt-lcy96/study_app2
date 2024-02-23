import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/app_colors.dart';
import 'package:study_app_2/configs/themes/ui_parameters.dart';
import 'package:study_app_2/controllers/theme_controller.dart';
import 'package:study_app_2/controllers/zoom_drawer_controller.dart';

class MenuScreen extends GetView<MyZoomDrawerController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return Container(
          padding: UIParameters.mobileScreenPadding,
          width: double.maxFinite,
          decoration: BoxDecoration(gradient: mainGradient()),
          child: Theme(
            data: ThemeData(
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(primary: onSurfaceTextColor))),
            child: SafeArea(
                child: Stack(
              children: [
                Positioned(
                    top: 0,
                    right: 0,
                    child: BackButton(
                      color: Colors.white,
                      onPressed: () {
                        controller.toggleDrawer();
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.3),
                  child: Column(
                    children: [
                      Obx(() => controller.user.value == null
                          ? const SizedBox()
                          : Text(controller.user.value!.displayName ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18.sp,
                                color: onSurfaceTextColor,
                              ))),
                      const Spacer(flex: 1),
                      _DrawerButton(
                          icon: Icons.web,
                          label: "website",
                          onPressed: () => controller.website()),
                      _DrawerButton(
                          icon: Icons.facebook,
                          label: "facebook",
                          onPressed: () => controller.facebook()),
                      Padding(
                        padding: EdgeInsets.only(left: 25.w),
                        child: _DrawerButton(
                            icon: Icons.email,
                            label: "email",
                            onPressed: () => controller.email()),
                      ),
                      const Spacer(flex: 4),
                      _DrawerButton(
                          size: 30,
                          icon: themeController.isLightMode
                              ? Icons.toggle_off
                              : Icons.toggle_on,
                          label: "Dark Mode ",
                          onPressed: () {
                            themeController.toggleDarkmode();
                          }),
                      _DrawerButton(
                          icon: Icons.logout,
                          label: "logout",
                          onPressed: () => controller.signOut()),
                    ],
                  ),
                )
              ],
            )),
          ));
    });
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton(
      {required this.icon,
      required this.label,
      this.onPressed,
      this.size = 15,
      super.key});

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final int size;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: size.sp),
      label: Text(label),
    );
  }
}

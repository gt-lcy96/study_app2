import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:study_app_2/configs/themes/app_icons.dart';
import 'package:study_app_2/configs/themes/custom_textStyle.dart';
import 'package:study_app_2/configs/themes/ui_parameters.dart';
import 'package:study_app_2/routes/routes.dart';
import 'package:study_app_2/widgets/app_circle_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  const CustomAppBar({
    super.key,
    this.title = '',
    this.showActionIcon = false,
    this.leading,
    this.titleWidget,
    this.onMenuActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mobileScreenPadding,
        vertical: mobileScreenPadding,
      ),
      child: Stack(children: [
        Positioned.fill(
          child: titleWidget == null
              ? Center(
                  child: Text(title, style: appBarTS),
                )
              : Center(child: titleWidget),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading ??
                  Transform.translate(
                    offset: const Offset(-14, 0),
                    child: const BackButton(),
                  ),
              if (showActionIcon)
                Transform.translate(
                  offset: const Offset(10, 0),
                  child: AppCircleButton(
                    child: Icon(
                      Icons.menu,
                      size: 22.sp,
                    ),
                    onTap: onMenuActionTap ?? () => Get.toNamed(AppRoutes.TEST_OVERVIEW),
                  ),
                ),
            ]),
      ]),
    ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}

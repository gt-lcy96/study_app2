import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_app_2/configs/themes/custom_textStyle.dart';

class CountDownTimer extends StatelessWidget {
  final Color? color;
  final String time;

  const CountDownTimer({
    super.key,
    this.color,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color ?? Theme.of(context).primaryColor,
        ),
        SizedBox(width: 5.w),
        Text(
          time,
          style: countDownTimerTS().copyWith(color: color),
          
        )
      ],
    );
  }
}

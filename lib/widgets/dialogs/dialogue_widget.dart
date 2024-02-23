import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dialogs {
  static final Dialogs _singleton = Dialogs._internal();

  Dialogs._internal();

  factory Dialogs() {
    return _singleton;
  }

  static Widget questionStartDialogue({required VoidCallback onTap}) {
    return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hi...",
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            )),
        const Text("Please login beore you start"),
      ],
    ),
    actions: [
      TextButton(onPressed: onTap, child: Text("Confirm")),
    ]
    );
  }
}

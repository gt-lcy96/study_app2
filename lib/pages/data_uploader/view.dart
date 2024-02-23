import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:study_app_2/firebase_ref/loading_status.dart';
import 'package:study_app_2/pages/data_uploader/controller.dart';
import 'package:get/get.dart';

class DataUploaderScreen extends GetView<DataUploaderController> {
  const DataUploaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() =>
            controller.state.loadingStatus == LoadingStatus.completed
                ? Text("Uploaded")
                : Text('uploading')),
      ),
    );
  }
}

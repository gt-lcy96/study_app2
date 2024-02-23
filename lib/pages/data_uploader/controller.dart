import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_app_2/firebase_ref/loading_status.dart';
import 'package:study_app_2/firebase_ref/references.dart';
import 'package:study_app_2/models/question_paper_model.dart';
import 'package:study_app_2/pages/data_uploader/index.dart';

class DataUploaderController extends GetxController {
  final state = DataUploaderState();

  void onReady() {
    uploadData();
    super.onReady();
  }

  Future<void> uploadData() async {
    state.loadingStatus.value = LoadingStatus.loading;

    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/gpt_papers") && path.contains('.json'))
        .toList();
    List<QuestionPaperModel> questionPapers = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
    }
    print('Items number ${questionPapers[2].title}');

    var batch = fireStore.batch();

    for (var paper in questionPapers) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.image_url,
        "description": paper.description,
        "time_seconds": paper.time_seconds,
        "questions_count":
            paper.questions == null ? 0 : paper.questions?.length,
      });

      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id!, questionId: questions.id);
        batch.set(questionPath, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer,
        });

        for (var answer in questions.answers) {
          batch.set(
              questionPath.collection("answers").doc(answer.identifier), {
                "identifier": answer.identifier,
                "answer": answer.answer,
              });
        }
      }
    }

    batch.commit();
    state.loadingStatus.value = LoadingStatus.completed;
  }
}

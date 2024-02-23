import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerModel {
  String identifier;
  String answer;

  AnswerModel({required this.identifier, required this.answer});

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      identifier: json["identifier"],
      answer: json["Answer"],
    );
  }

  factory AnswerModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return AnswerModel(
      identifier: snapshot["identifier"] as String,
      answer: snapshot["answer"] as String,
    );
  }
}

class QuestionModel {
  String id;
  String question;
  List<AnswerModel> answers;
  String? correctAnswer;
  String? selectedAnswer;

  QuestionModel({
    required this.id,
    required this.question,
    required this.answers,
    this.correctAnswer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json["id"] as String,
      question: json["question"] as String,
      answers: (json["answers"] as List)
          .map((e) => AnswerModel.fromJson(e))
          .toList(),
      correctAnswer: json["correct_answer"] as String,
    );
  }

  factory QuestionModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return QuestionModel(
      id: snapshot.id,
      question: snapshot["question"],
      answers: [],
      correctAnswer: snapshot["correct_answer"],
    );
  }
}

class QuestionPaperModel {
  String? id;
  String? title;
  String? image_url;
  String? description;
  int? time_seconds;
  List<QuestionModel>? questions;
  int questionCount;

  QuestionPaperModel({
    this.id,
    this.title,
    this.image_url,
    this.description,
    this.time_seconds,
    this.questions,
    required this.questionCount,
  });

  factory QuestionPaperModel.fromJson(Map<String, dynamic> json) {
    return QuestionPaperModel(
      id: json["id"] as String,
      title: json["title"] as String,
      image_url: json["image_url"] as String,
      description: json["Description"] as String,
      time_seconds: json["time_seconds"] as int,
      questionCount: 0,
      questions: (json["questions"] as List)
          .map((dynamic e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory QuestionPaperModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> json) {
    return QuestionPaperModel(
      id: json.id,
      title: json["title"],
      image_url: json["image_url"],
      description: json["description"],
      time_seconds: json["time_seconds"],
      questionCount: json['questions_count'] as int,
      questions: [],
    );
  }

  String timeInMinits() => "${(time_seconds! / 60).ceil()} mins";
}

import 'package:ptit_quiz_frontend/domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    required super.content,
    required super.answers,
    required super.correctAnswer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      content: json['content'],
      answers: List<String>.from(json['answers']),
      correctAnswer: json['correctAnswer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'answers': answers,
      'correctAnswer': correctAnswer,
    };
  }
}
import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    required super.content,
    required super.answers,
    super.correctAnswer,
  });

  factory QuestionModel.fromEntity(Question question) {
    return QuestionModel(
      content: question.content,
      answers: question.answers,
      correctAnswer: question.correctAnswer,
    );
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      content: json['content'],
      answers: List<String>.from(json['answers']),
      correctAnswer: json['correctAnswer'],
    );
  }

  static List<QuestionModel>? fromJsonList(List<dynamic> json) {
    return json.map((question) => QuestionModel.fromJson(question)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'answers': answers,
      'correctAnswer': correctAnswer,
    };
  }

  static List<Map<String, dynamic>>? toJsonList(List<QuestionModel>? questions) {
    return questions?.map((question) => question.toJson()).toList();
  }

  static List<Question> toEntityList(List<QuestionModel> questions) {
    return questions.map((question) => question).toList();
  }

  static List<QuestionModel>? fromEntityList(List<Question>? questions) {
    return questions?.map((question) => QuestionModel.fromEntity(question)).toList();
  }
}
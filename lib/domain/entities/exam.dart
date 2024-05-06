import 'question.dart';

class Exam {
  final String id;
  final String name;
  final int duration;
  final int? start;
  final List<Question>? questions;

  Exam({
    required this.id,
    required this.name,
    required this.duration,
    required this.start,
    this.questions,
  });

  const Exam.empty()
      : id = '',
        name = '',
        duration = 0,
        start = 0,
        questions = null;

  Exam copyWith({
    String? id,
    String? name,
    int? duration,
    int? start,
    List<Question>? questions,
  }) {
    return Exam(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      start: start ?? this.start,
      questions: questions ?? this.questions,
    );
  }
}
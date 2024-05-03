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
}
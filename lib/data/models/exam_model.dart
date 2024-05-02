import '../../domain/entities/exam.dart';

class ExamModel extends Exam {
  ExamModel({
    required super.id,
    required super.name,
    required super.duration,
    required super.start,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      start: json['start'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'start': start,
    };
  }

  factory ExamModel.fromEntity(Exam exam) {
    return ExamModel(
      id: exam.id,
      name: exam.name,
      duration: exam.duration,
      start: exam.start,
    );
  }
}
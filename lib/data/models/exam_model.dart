import '../../domain/entities/exam.dart';

class ExamModel extends Exam {
  ExamModel({
    required super.id,
    required super.name,
    required super.subject,
    required super.duration,
    required super.description,
    required super.startTime,
    required super.endTime,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'],
      name: json['name'],
      subject: json['subject'],
      duration: json['duration'],
      description: json['description'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subject': subject,
      'duration': duration,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory ExamModel.fromEntity(Exam exam) {
    return ExamModel(
      id: exam.id,
      name: exam.name,
      subject: exam.subject,
      duration: exam.duration,
      description: exam.description,
      startTime: exam.startTime,
      endTime: exam.endTime,
    );
  }
}
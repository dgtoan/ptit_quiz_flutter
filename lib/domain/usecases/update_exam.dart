import 'package:ptit_quiz_frontend/data/models/exam_model.dart';
import 'package:ptit_quiz_frontend/domain/entities/exam.dart';
import 'package:ptit_quiz_frontend/domain/repositories/exam_repository.dart';

class UpdateExam {
  final ExamRepository _examRepository;

  UpdateExam({required ExamRepository examRepository}) : _examRepository = examRepository;

  Future<Exam> call(Exam exam) {
    return _examRepository.updateExam(exam);
  }
}
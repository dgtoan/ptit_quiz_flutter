import 'package:ptit_quiz_frontend/domain/entities/exam.dart';

import '../repositories/exam_repository.dart';
import '../../data/models/exam_model.dart';

class CreateExam {
  final ExamRepository _examRepository;

  CreateExam({required ExamRepository examRepository}) : _examRepository = examRepository;

  Future<Exam> call(Exam exam) {
    return _examRepository.createExam(exam);
  }
}
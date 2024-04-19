import 'package:ptit_quiz_frontend/domain/entities/exam.dart';

import '../../data/models/exam_model.dart';

abstract class ExamRepository {
  Future<Exam> createExam(Exam exam);
  Future<Exam> updateExam(Exam exam);
  Future<Exam> deleteExam(String id);
  Future<List<Exam>> getExams();
  Future<Exam> getExam(String id);
}
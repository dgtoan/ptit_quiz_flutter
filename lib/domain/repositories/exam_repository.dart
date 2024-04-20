import '../entities/exam.dart';

abstract class ExamRepository {
  Future<Exam> createExam(Exam exam);
  Future<Exam> updateExam(Exam exam);
  Future<Exam> deleteExam(String id);
  Future<List<Exam>> getExams();
  Future<Exam> getExam(String id);
}
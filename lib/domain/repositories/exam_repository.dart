import '../entities/exam.dart';

abstract class ExamRepository {
  Future<Exam> createExam(Exam exam);
  Future<Exam> updateExam(Exam exam);
  Future<Exam> deleteExam(String id);
  Future<List<Exam>> getExams();
  Future<Exam> getExam(String id);
  Future<Map<String, dynamic>> submitExam(String id, List<int> answers);
  Future<List<Map<String, dynamic>>> getExamResults();
  Future<Map<String, dynamic>> getExamResult(String id);
}
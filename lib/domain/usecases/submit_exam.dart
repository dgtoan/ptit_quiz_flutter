import '../repositories/exam_repository.dart';

class SubmitExam {
  final ExamRepository _examRepository;

  SubmitExam({required ExamRepository examRepository}) : _examRepository = examRepository;

  Future<Map<String, dynamic>> call(String id, List<int> answers) {
    return _examRepository.submitExam(id, answers);
  }
}
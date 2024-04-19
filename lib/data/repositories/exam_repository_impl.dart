import 'package:ptit_quiz_frontend/data/models/exam_model.dart';
import 'package:ptit_quiz_frontend/data/providers/remote_data.dart';

import '../../domain/entities/exam.dart';
import '../../domain/repositories/exam_repository.dart';

class ExamRepositoryImpl implements ExamRepository {
  final RemoteData remoteData;

  ExamRepositoryImpl({required this.remoteData});

  @override
  Future<Exam> createExam(Exam exam) async {
    return await remoteData.createExam(ExamModel.fromEntity(exam));
  }

  @override
  Future<Exam> updateExam(Exam exam) async {
    return await remoteData.updateExam(ExamModel.fromEntity(exam));
  }

  @override
  Future<Exam> deleteExam(String id) async {
    return await remoteData.deleteExam(id);
  }

  @override
  Future<List<Exam>> getExams() async {
    return await remoteData.getExams();
  }

  @override
  Future<Exam> getExam(String id) async {
    return await remoteData.getExam(id);
  }
}
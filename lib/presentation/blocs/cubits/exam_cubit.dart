import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptit_quiz_frontend/domain/entities/exam.dart';
import '../../../domain/entities/question.dart';

class ExamCubit extends Cubit<Exam> {
  ExamCubit() : super(const Exam.empty());

  void setExam(Exam exam) => emit(exam);

  void setName(String name) {
    final exam = state.copyWith(name: name);
    emit(exam);
  }

  void setDuration(int duration) {
    final exam = state.copyWith(duration: duration);
    emit(exam);
  }

  void setStart(int start) {
    final exam = state.copyWith(start: start);
    emit(exam);
  }

  void setQuestions(List<Question> questions) {
    final exam = state.copyWith(questions: questions);
    emit(exam);
  }

  void addQuestion(Question question) {
    final questions = state.questions ?? <Question>[];
    questions.add(question);
    final exam = state.copyWith(questions: questions);
    emit(exam);
  }

  void updateQuestion(Question question, int index) {
    final questions = state.questions ?? <Question>[];
    questions[index] = question;
    final exam = state.copyWith(questions: questions);
    emit(exam);
  }

  void removeQuestion(int index) {
    final questions = state.questions ?? <Question>[];
    questions.removeAt(index);
    final exam = state.copyWith(questions: questions);
    emit(exam);
  }

  void clear() => emit(const Exam.empty());
}
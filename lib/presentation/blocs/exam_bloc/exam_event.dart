part of 'exam_bloc.dart';

abstract class ExamEvent extends Equatable {
  const ExamEvent();
}

class FetchExamsEvent extends ExamEvent {
  const FetchExamsEvent();

  @override
  List<Object> get props => [];
}

class CreateExamEvent extends ExamEvent {
  final Exam exam;
  const CreateExamEvent({required this.exam});

  @override
  List<Object> get props => [exam];
}

class UpdateExamEvent extends ExamEvent {
  final Exam exam;
  const UpdateExamEvent({required this.exam});

  @override
  List<Object> get props => [exam];
}

class DeleteExamEvent extends ExamEvent {
  final String id;
  const DeleteExamEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchExamEvent extends ExamEvent {
  final String id;
  const FetchExamEvent({required this.id});

  @override
  List<Object> get props => [id];
}

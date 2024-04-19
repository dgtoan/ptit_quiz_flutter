part of 'exam_bloc.dart';

class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

class ExamStateLoading extends ExamState {
  const ExamStateLoading();

  @override
  List<Object> get props => [];
}

class ExamStateLoaded extends ExamState {
  final List<Exam> exams;
  const ExamStateLoaded({required this.exams});

  @override
  List<Object> get props => [exams];
}

class ExamStateError extends ExamState {
  final String message;
  const ExamStateError({required this.message});

  @override
  List<Object> get props => [message];
}

class ExamStateCreated extends ExamState {
  final Exam exam;
  const ExamStateCreated({required this.exam});

  @override
  List<Object> get props => [exam];
}

class ExamStateUpdated extends ExamState {
  final Exam exam;
  const ExamStateUpdated({required this.exam});

  @override
  List<Object> get props => [exam];
}

class ExamStateDeleted extends ExamState {
  const ExamStateDeleted();

  @override
  List<Object> get props => [];
}

class ExamStateFetched extends ExamState {
  final Exam exam;
  const ExamStateFetched({required this.exam});

  @override
  List<Object> get props => [exam];
}
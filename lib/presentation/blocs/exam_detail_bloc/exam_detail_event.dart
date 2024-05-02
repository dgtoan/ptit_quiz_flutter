part of 'exam_detail_bloc.dart';

sealed class ExamDetailEvent extends Equatable {
  const ExamDetailEvent();

  @override
  List<Object> get props => [];
}

final class ExamDetailGetEvent extends ExamDetailEvent {
  final String examId;

  const ExamDetailGetEvent({
    required this.examId,
  });

  @override
  List<Object> get props => [examId];
}

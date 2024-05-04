import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ptit_quiz_frontend/domain/usecases/get_exam.dart';

import '../../../domain/entities/exam.dart';
import '../../../domain/usecases/submit_exam.dart';

part 'exam_detail_event.dart';
part 'exam_detail_state.dart';

class ExamDetailBloc extends Bloc<ExamDetailEvent, ExamDetailState> {
  late GetExam _getExam;
  late SubmitExam _submitExam;

  ExamDetailBloc({
    required GetExam getExam,
    required SubmitExam submitExam,
  }) : super(ExamDetailInitial()) {
    _getExam = getExam;
    _submitExam = submitExam;

    on<ExamDetailGetEvent>(_onGetExam);
    on<ExamDetailSubmitEvent>(_onSubmitExam);
  }

  Future<void> _onGetExam(ExamDetailGetEvent event, Emitter<ExamDetailState> emit) async {
    emit(ExamDetailLoading());
    try {
      final exam = await _getExam(event.examId);
      emit(ExamDetailLoaded(exam: exam));
    } catch (e) {
      emit(ExamDetailError(message: e.toString()));
    }
  }

  Future<void> _onSubmitExam(ExamDetailSubmitEvent event, Emitter<ExamDetailState> emit) async {
    emit(ExamDetailLoading());
    try {
      final result = await _submitExam(event.examId, event.answers);
      emit(ExamDetailSubmitted(result: result));
    } catch (e) {
      emit(ExamDetailError(message: e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ptit_quiz_frontend/domain/usecases/get_exam.dart';

import '../../../domain/entities/exam.dart';

part 'exam_detail_event.dart';
part 'exam_detail_state.dart';

class ExamDetailBloc extends Bloc<ExamDetailEvent, ExamDetailState> {
  late GetExam _getExam;

  ExamDetailBloc({
    required GetExam getExam,
  }) : super(ExamDetailInitial()) {
    _getExam = getExam;

    on<ExamDetailGetEvent>(_onGetExam);
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
}

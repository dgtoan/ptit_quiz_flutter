import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ptit_quiz_frontend/domain/usecases/get_exam.dart';
import 'package:ptit_quiz_frontend/domain/usecases/get_exams.dart';

import '../../../domain/entities/exam.dart';
import '../../../domain/usecases/create_exam.dart';
import '../../../domain/usecases/delete_exam.dart';
import '../../../domain/usecases/update_exam.dart';

part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  late CreateExam _createExam;
  late UpdateExam _updateExam;
  late DeleteExam _deleteExam;
  late GetExams _getExams;
  late GetExam _getExam;

  ExamBloc({
    required CreateExam createExam,
    required UpdateExam updateExam,
    required DeleteExam deleteExam,
    required GetExams getExams,
    required GetExam getExam,
  }) : super(const ExamState()) {
    _createExam = createExam;
    _updateExam = updateExam;
    _deleteExam = deleteExam;
    _getExams = getExams;
    _getExam = getExam;

    on<FetchExamsEvent>(_onFetchExams);
    on<CreateExamEvent>(_onCreateExam);
    on<UpdateExamEvent>(_onUpdateExam);
    on<DeleteExamEvent>(_onDeleteExam);
    on<FetchExamEvent>(_onFetchExam);
  }

  Future<void> _onFetchExams(FetchExamsEvent event, Emitter<ExamState> emit) async {
    emit(const ExamStateLoading());
    try {
      final exams = await _getExams();
      emit(ExamStateLoaded(exams: exams));
    } catch (e) {
      emit(ExamStateError(message: e.toString()));
    }
  }

  Future<void> _onCreateExam(CreateExamEvent event, Emitter<ExamState> emit) async {
    emit(const ExamStateLoading());
    try {
      final response = await _createExam(event.exam);
      emit(ExamStateCreated(exam: response));
    } catch (e) {
      emit(ExamStateError(message: e.toString()));
    }
  }

  Future<void> _onUpdateExam(UpdateExamEvent event, Emitter<ExamState> emit) async {
    emit(const ExamStateLoading());
    try {
      final response = await _updateExam(event.exam);
      emit(ExamStateUpdated(exam: response));
    } catch (e) {
      emit(ExamStateError(message: e.toString()));
    }
  }

  Future<void> _onDeleteExam(DeleteExamEvent event, Emitter<ExamState> emit) async {
    emit(const ExamStateLoading());
    try {
      final response = await _deleteExam(event.id);
      emit(ExamStateDeleted());
    } catch (e) {
      emit(ExamStateError(message: e.toString()));
    }
  }

  Future<void> _onFetchExam(FetchExamEvent event, Emitter<ExamState> emit) async {
    emit(const ExamStateLoading());
    try {
      final response = await _getExam(event.id);
      emit(ExamStateFetched(exam: response));
    } catch (e) {
      emit(ExamStateError(message: e.toString()));
    }
  }
  
}
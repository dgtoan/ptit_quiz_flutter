import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ptit_quiz_frontend/core/utils/ticker.dart';
import 'package:ptit_quiz_frontend/domain/usecases/get_exam_result.dart';
import 'package:ptit_quiz_frontend/domain/usecases/get_exam_results.dart';
import 'package:ptit_quiz_frontend/domain/usecases/submit_exam.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/dio/dio_tools.dart';
import 'domain/usecases/validate.dart';
import 'domain/usecases/validate_admin.dart';
import 'presentation/blocs/app_bloc.dart';

import 'data/providers/remote_data.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/providers/local_data.dart';
import 'data/repositories/exam_repository_impl.dart';

import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login.dart';
import 'domain/usecases/logout.dart';
import 'domain/repositories/exam_repository.dart';
import 'domain/usecases/admin_login.dart';
import 'domain/usecases/create_exam.dart';
import 'domain/usecases/delete_exam.dart';
import 'domain/usecases/get_exam.dart';
import 'domain/usecases/get_exams.dart';
import 'domain/usecases/register.dart';
import 'domain/usecases/update_exam.dart';

class DependencyInjection {
  static final GetIt sl = GetIt.instance;

  static Future<void> init() async {
    // bloc
    sl.registerFactory<AuthBloc>(
      () => AuthBloc(
        login: sl(),
        logout: sl(),
        register: sl(),
        adminLogin: sl(),
        validate: sl(),
        validateAdmin: sl(),
        authSubscription: DioTools.registerInceptor(sl<Dio>()),
      ),
    );

    sl.registerFactory<ExamBloc>(
      () => ExamBloc(
        getExams: sl(),
        getExam: sl(),
        createExam: sl(),
        updateExam: sl(),
        deleteExam: sl(),
      ),
    );

    sl.registerFactory<ExamDetailBloc>(
      () => ExamDetailBloc(
        getExam: sl(),
        submitExam: sl(),
      ),
    );

    sl.registerFactory<ResultBloc>(
      () => ResultBloc(
        getExamResults: sl(),
      ),
    );

    sl.registerFactory<ResultDetailBloc>(
      () => ResultDetailBloc(
        getExamResult: sl(),
      ),
    );

    sl.registerFactory<AnswersCubit>(
      () => AnswersCubit(),
    );

    sl.registerFactory<TimerCubit>(
      () => TimerCubit(ticker: const Ticker()),
    );

    sl.registerFactory<ExamCubit>(
      () => ExamCubit(),
    );

    // use case
    sl.registerLazySingleton<Login>(() => Login(authRepository: sl()));
    sl.registerLazySingleton<Logout>(() => Logout(authRepository: sl()));
    sl.registerLazySingleton<Register>(() => Register(authRepository: sl()));
    sl.registerLazySingleton<AdminLogin>(() => AdminLogin(authRepository: sl())); 
    sl.registerLazySingleton<Validate>(() => Validate(authRepository: sl()));
    sl.registerLazySingleton<ValidateAdmin>(() => ValidateAdmin(authRepository: sl()));
    sl.registerLazySingleton<GetExams>(() => GetExams(examRepository: sl()));
    sl.registerLazySingleton<GetExam>(() => GetExam(examRepository: sl()));
    sl.registerLazySingleton<CreateExam>(() => CreateExam(examRepository: sl()));
    sl.registerLazySingleton<SubmitExam>(() => SubmitExam(examRepository: sl()));
    sl.registerLazySingleton<GetExamResult>(() => GetExamResult(examRepository: sl()));
    sl.registerLazySingleton<GetExamResults>(() => GetExamResults(examRepository: sl()));
    sl.registerLazySingleton<UpdateExam>(() => UpdateExam(examRepository: sl()));
    sl.registerLazySingleton<DeleteExam>(() => DeleteExam(examRepository: sl()));

    // repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        localData: sl(),
        remoteData: sl(),
      ),
    );
    sl.registerLazySingleton<ExamRepository>(
      () => ExamRepositoryImpl(remoteData: sl())
    );

    // data
    sl.registerLazySingleton<RemoteData>(() => RemoteDataImpl(dio: sl()));
    sl.registerLazySingleton<LocalData>(() => LocalDataImpl(sharedPreferences: sl()));

    // third party
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    sl.registerLazySingleton<Dio>(() => DioTools.dio);
  }
}
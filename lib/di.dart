import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ptit_quiz_frontend/core/dio/dio_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/providers/remote_data.dart';

class DependencyInjection {
  static final GetIt sl = GetIt.instance;

  static Future<void> init() async {
    sl.registerLazySingleton<RemoteData>(() => RemoteDataImpl(dio: sl()));


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    sl.registerLazySingleton<Dio>(() => DioTools.dio);
  }
}
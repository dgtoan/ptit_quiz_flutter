import 'package:dio/dio.dart';

class DioTools {
  static String getBaseUrl() {
    return 'https://ptit-quiz.onrender.com';
  }

  static Dio get dio {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: getBaseUrl(),
        validateStatus: (status) => status! < 500,
        headers: {
          'Content-Type': 'application/json',
        },
      )
    );
    return dio;
  }
}
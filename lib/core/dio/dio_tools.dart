import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ptit_quiz_frontend/di.dart';

import '../../data/providers/local_data.dart';

class DioTools {
  static String getBaseUrl() {
    return 'https://ptit-quiz.onrender.com';
  }

  static Dio get dio {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: getBaseUrl(),
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        validateStatus: (status) => status! < 500,
        headers: {
          'Content-Type': 'application/json',
        },
      )
    );
    return dio;
  }

  static  Stream<bool> registerInceptor(Dio dio) {
    StreamController<bool> streamController = StreamController<bool>();
    Stream<bool> stream = streamController.stream;

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['access_token'] = DependencyInjection.sl<LocalData>().getToken();
        return handler.next(options);
      },

      onResponse: (response, handler) {
        // if (response.statusCode == 401) {
        //   streamController.add(false);
        // }
        return handler.next(response);
      },

      onError: (DioException error, handler) {
        streamController.add(false);
        return handler.next(error);
      },
    ));

    return stream;
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/account_model.dart';
import '../models/exam_model.dart';
import '../models/profile_model.dart';
import '../../domain/entities/exam.dart';

abstract class RemoteData {
  Future<Map<String, dynamic>> login(AccountModel user);
  Future<Map<String, dynamic>> adminLogin(AccountModel user);
  Future<Map<String, dynamic>> register(AccountModel user, ProfileModel profile);
  Future<Map<String, dynamic>> validate();
  Future<Map<String, dynamic>> validateAdmin();
  Future<Map<String, dynamic>> refreshToken(String refreshToken);
  Future<Map<String, dynamic>> refreshTokenAdmin(String refreshToken);

  Future<Exam> createExam(ExamModel exam);
  Future<Exam> updateExam(ExamModel exam);
  Future<Exam> deleteExam(String id);
  Future<List<ExamModel>> getExams();
  Future<Exam> getExam(String id);
}

class RemoteDataImpl implements RemoteData {
  final Dio dio;

  RemoteDataImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> login(AccountModel user) async {
    final response = await dio.post("/auth/login", data: user.toJson());
    switch (response.statusCode) {
      case 200:
        return {
          "access_token": response.data["access_token"],
          "refresh_token": response.data["refresh_token"],
        };
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<Map<String, dynamic>> adminLogin(AccountModel user) async {
    final response = await dio.post("/admin/auth/login", data: user.toJson());
    switch (response.statusCode) {
      case 200:
        return {
          "access_token": response.data["access_token"],
          "refresh_token": response.data["refresh_token"],
        };
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<Map<String, dynamic>> register(AccountModel user, ProfileModel profile) async {
    final response = await dio.post(
      "/auth/register",
      data: {
        "email": user.email,
        "password": user.password,
        "fullName": profile.fullName,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 204:
        return {
          "access_token": response.data["access_token"],
          "refresh_token": response.data["refresh_token"],
        };
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<Map<String, dynamic>> validate() async {
    final response = await dio.get("/auth/validate");
    switch (response.statusCode) {
      case 200:
        return {"id": response.data["_id"]};
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<Map<String, dynamic>> validateAdmin() async {
    final response = await dio.get("/admin/auth/validate");
    switch (response.statusCode) {
      case 200:
        return {"id": response.data["_id"]};
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    dio.options.headers["refresh_token"] = refreshToken;
    final response = await dio.post("/auth/refresh_token");
    switch (response.statusCode) {
      case 200:
        return {
          "access_token": response.data["access_token"],
          "refresh_token": response.data["refresh_token"],
        };
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<Map<String, dynamic>> refreshTokenAdmin(String refreshToken) async {
    dio.options.headers["refresh_token"] = refreshToken;
    final response = await dio.post("/admin/auth/refresh_token");
    switch (response.statusCode) {
      case 200:
        return {
          "access_token": response.data["access_token"],
          "refresh_token": response.data["refresh_token"],
        };
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<ExamModel> createExam(ExamModel exam) async {
    final response = await dio.post("/admin/exams", data: exam.toJson());
    switch (response.statusCode) {
      case 201:
        return ExamModel.fromJson(response.data);
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<ExamModel> updateExam(ExamModel exam) async {
    final response = await dio.put("/admin/exams/${exam.id}", data: exam.toJson());
    switch (response.statusCode) {
      case 200:
        return ExamModel.fromJson(response.data);
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<ExamModel> deleteExam(String id) async {
    final response = await dio.delete("/admin/exams/$id");
    switch (response.statusCode) {
      case 204:
        return ExamModel.fromJson(response.data);
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<List<ExamModel>> getExams() async {
    final response = await dio.get("/exams");
    switch (response.statusCode) {
      case 200:
        return (response.data as List).map((e) => ExamModel.fromJson(e)).toList();
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }

  @override
  Future<ExamModel> getExam(String id) async {
    final response = await dio.get("/exams/$id");
    switch (response.statusCode) {
      case 200:
        return ExamModel.fromJson(response.data);
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: jsonEncode(response.data),
        );
    }
  }
}
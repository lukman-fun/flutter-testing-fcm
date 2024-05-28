import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/khs_model.dart';
import 'package:testing/domain/models/student_result_kbm.dart';
import 'package:testing/domain/models/success_model.dart';
import 'package:testing/domain/models/transcript_model.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class StudyResultRepository extends RepositoryApp {
  Future<TranscriptModel> transcript(String? parentId) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'student-result/transcript',
        queryParameters: {
          'parent_id': parentId,
        },
      );

      return transcriptModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<KhsModel> khs(classesId, semesterId, String? parentId) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'student-result/khs',
        queryParameters: {
          'class': classesId,
          'semester': semesterId,
          'parent_id': parentId,
        },
      );

      return khsModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<StudentResultKbmModel> kbm_schedule(
    String semester,
    String classes,
    String student,
    String study_year,
  ) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'student-result/kbm-schedule',
        queryParameters: {
          'class': classes,
          'semester': semester,
          'student': student,
          'study_year': study_year
        },
      );

      return studentResultKbmModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<SuccessModel> save_kbm_result(Map<String, dynamic> body) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.post(
        'student-result/save-kbm-schedule',
        data: body,
      );

      return successModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}

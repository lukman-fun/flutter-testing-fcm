import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/academic_announcement_model.dart';
import 'package:testing/domain/models/exam_model.dart';
import 'package:testing/domain/models/kbm_model.dart';
import 'package:testing/domain/models/krs_model.dart';
import 'package:testing/domain/models/teacher_kbm_model.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class ScheduleRepository extends RepositoryApp {
  Future<AcademicAnnouncementModel> academic_announcement() async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get('schedule/registration');

      return academicAnnouncementModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<KrsModel> krs(String? parentId) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'schedule/krs',
        queryParameters: {
          'parent_id': parentId,
        },
      );

      return krsModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<KbmModel> kbm(String day, String? parentId) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'schedule/kbm',
        queryParameters: {
          'day': day,
          'parent_id': parentId,
        },
      );

      return kbmModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<ExamModel> exam(String? parentId) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'schedule/exam',
        queryParameters: {
          'parent_id': parentId,
        },
      );

      return examModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<TeacherKbmModel> teacher_kbm(String day) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'schedule/teacher-kbm',
        queryParameters: {
          'day': day,
        },
      );

      return teacherKbmModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/attendance_history.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class AttendanceRepository extends RepositoryApp {
  Future<AttendanceHistoryModel> get(
    studyYearId,
    classesId,
    semesterId,
    String? parentId,
  ) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'attendance',
        queryParameters: {
          'study_year': studyYearId,
          'class': classesId,
          'semester': semesterId,
          'parent_id': parentId,
        },
      );

      return attendanceHistoryModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}

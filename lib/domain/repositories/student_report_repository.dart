import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/student_report_model.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class StudentReportRepository extends RepositoryApp {
  Future<StudentReportModel> get(String? parentId) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'student-report',
        queryParameters: {
          'parent_id': parentId,
        },
      );

      return studentReportModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}

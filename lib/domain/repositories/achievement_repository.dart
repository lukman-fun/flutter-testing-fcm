import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/student_achievement_model.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class AchievementRepository extends RepositoryApp {
  Future<StudentAchievementModel> student_achievement(
      String type, String? parentId) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'student-achievement',
        queryParameters: {
          'type': type,
          'parent_id': parentId,
        },
      );

      return studentAchievementModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}

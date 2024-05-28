import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/notification_model.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class NotificationRepository extends RepositoryApp {
  Future<NotificationModel> notification() async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get('notification');

      return notificationModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}

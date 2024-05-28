import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/login_model.dart';
import 'package:testing/domain/models/profile_model.dart';
import 'package:testing/domain/models/success_model.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class AuthRepository extends RepositoryApp {
  Future<LoginModel> login(Map<String, dynamic> body) async {
    try {
      final response = await dio.post('auth/login', data: body);

      print('OKE: ${json.encode(response.data)}');
      // print('NOS: ${loginModelFromJson(json.encode(response.data))}');
      return loginModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        var validationError = '';
        for (String message in e.response?.data['validation']) {
          validationError += '$message\n';
        }
        throw validationError.substring(0, validationError.length - 2);
      }
      throw e.response?.data['message'];
    }
  }

  Future<SuccessModel> register(FormData body) async {
    try {
      final response = await dio.post('auth/register', data: body);

      return successModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        var validationError = '';
        for (String message in e.response?.data['validation']) {
          validationError += '$message\n';
        }
        throw validationError.substring(0, validationError.length - 2);
      }
      throw e.response?.data['message'];
    }
  }

  Future<ProfileModel> profile(String? parentId) async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get(
        'auth/me',
        queryParameters: {'parent_id': parentId},
      );

      return profileModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<LoginModel> refresh_token() async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.post('auth/refresh');

      return loginModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}

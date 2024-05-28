import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/article_model.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class ArticleRepository extends RepositoryApp {
  Future<ArticleModel> article() async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get('article');

      return articleModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}

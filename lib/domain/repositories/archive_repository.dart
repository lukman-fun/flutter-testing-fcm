import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testing/domain/models/archive_file.dart';
import 'package:testing/domain/repositories/repository_app.dart';

class ArchiveRepository extends RepositoryApp {
  Future<ArchiveFileModel> archive_file() async {
    try {
      dio.options.headers['auth-token'] = true;
      final response = await dio.get('archive-file');

      return archiveFileModelFromJson(json.encode(response.data));
    } on DioException catch (e) {
      throw e.response?.data['message'];
    }
  }
}

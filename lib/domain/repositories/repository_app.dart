import 'package:dio/dio.dart';
import 'package:testing/domain/server/server_app.dart';

abstract class RepositoryApp {
  late Dio dio;
  RepositoryApp() {
    dio = ServerApp().dio;
  }
}

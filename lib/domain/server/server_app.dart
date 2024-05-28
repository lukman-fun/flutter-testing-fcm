import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:testing/domain/server/server_auth_interceptor.dart';

class ServerApp {
  static const DEBUG = false;
  static const BASE_URL_DEV = 'http://192.168.18.53:8000/';
  static const BASE_URL_PROD = 'https://ptq-alkautsar.klinikrestubunda.my.id/';
  static const BASE_URL = DEBUG ? BASE_URL_DEV : BASE_URL_PROD;

  static const API = '${BASE_URL}api/';

  static const IMAGE_USER = '${BASE_URL}uploads/users/';
  static const IMAGE_ARTICLE = '${BASE_URL}uploads/article/';

  final Dio dio = Dio(
    BaseOptions(baseUrl: API),
  );

  ServerApp() {
    _setIntercept(ServerAuthInterceptor());
  }

  _setIntercept(Interceptor interceptor) {
    dio.interceptors.add(
      LogInterceptor(
        logPrint: (object) => debugPrint(object.toString()),
      ),
    );
    dio.interceptors.add(interceptor);
  }
}

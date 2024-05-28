import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;
import 'package:testing/domain/repositories/auth_repository.dart';
import 'package:testing/routers/route_name.dart';
import 'package:testing/utils/session_auth.dart';

class ServerAuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('auth-token') &&
        options.headers['auth-token'] == true) {
      options.headers.addAll(
        {
          'Authorization': 'Bearer ${await SessionAuth.getToken()}',
        },
      );
      print('token: ${await SessionAuth.getToken()}');
    }
    options.headers.remove('auth-token');
    print('body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('response data: ${response}');
    print('');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (err.response?.data['message'] == 'Token Expired') {
        try {
          await _refreshToken();
          handler.resolve(await _retry(err.requestOptions));
        } on DioException catch (e) {
          handler.next(e);
        }
        // Return to prevent the next interceptor in the chain from being executed.
        return;
      } else if (err.response?.data['message'] == 'Token Invalid') {
        SessionAuth.logout();
        getX.Get.offAllNamed(RouteName.STUDENT_LOGIN);
        return;
      }
    }
    print('ERROR: ${err.response}');
    print('');

    handler.next(err);
    // super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    Dio dio = Dio();

    final options = Options(
      method: requestOptions.method,
      headers: {
        "Authorization": "Bearer ${await SessionAuth.getToken()}",
      },
    );

    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> _refreshToken() async {
    try {
      final data = await AuthRepository().refresh_token();
      SessionAuth.setAuth(data);
      return true;
    } catch (e) {
      SessionAuth.logout();
      getX.Get.offAllNamed(RouteName.STUDENT_LOGIN);
      return true;
    }
  }
}

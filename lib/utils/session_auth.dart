import 'dart:convert';

import 'package:testing/domain/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionAuth {
  static const String KEY_SESSION = 'auth-date';

  static Future<void> setAuth(LoginModel data) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(KEY_SESSION, loginModelToJson(data));
  }

  static Future<LoginModel?> getAuth() async {
    final storage = await SharedPreferences.getInstance();
    return loginModelFromJson(storage.getString(KEY_SESSION)!);
  }

  static Future<void> setToken(String token) async {
    final storage = await SharedPreferences.getInstance();
    LoginModel loginModel = loginModelFromJson(storage.getString(KEY_SESSION)!);
    loginModel.authorization.token = token;
    await storage.setString(KEY_SESSION, loginModelToJson(loginModel));
  }

  static Future<String?> getToken() async {
    final storage = await SharedPreferences.getInstance();
    return loginModelFromJson(storage.getString(KEY_SESSION)!)
        .authorization
        .token;
  }

  static Future<bool> isAuth() async {
    final storage = await SharedPreferences.getInstance();
    return storage.getString(KEY_SESSION) != null;
  }

  static Future<void> logout() async {
    final storage = await SharedPreferences.getInstance();
    storage.remove(KEY_SESSION);
  }

  // static Future<void> setToken(String token) async {
  //   final storage = await SharedPreferences.getInstance();
  //   await storage.setString('auth-token', token);
  // }

  // static Future<String?> getToken() async {
  //   final storage = await SharedPreferences.getInstance();
  //   return storage.getString('auth-token');
  // }

  // static Future<bool> validToken() async {
  //   final storage = await SharedPreferences.getInstance();
  //   return storage.getString('auth-token') != null;
  // }

  // static Future<void> unsetToken() async {
  //   final storage = await SharedPreferences.getInstance();
  //   storage.remove('auth-token');
  // }
}

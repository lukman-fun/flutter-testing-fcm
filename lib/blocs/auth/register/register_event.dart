import 'dart:collection';

import 'package:dio/dio.dart';

abstract class RegisterEvent {}

class OnSignupRegister extends RegisterEvent {
  FormData body;

  OnSignupRegister(this.body);
}

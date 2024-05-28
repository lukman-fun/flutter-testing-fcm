import 'dart:collection';

abstract class LoginEvent {}

class OnLogin extends LoginEvent {
  HashMap<String, dynamic> body;

  OnLogin(this.body);
}

import 'package:testing/domain/models/success_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final SuccessModel successModel;

  RegisterSuccess(this.successModel);
}

class RegisterError extends RegisterState {
  final String error;

  RegisterError(this.error);
}

import 'package:testing/domain/models/regency_model.dart';

abstract class RegencyState {}

class RegencyInitial extends RegencyState {}

class RegencyLoading extends RegencyState {}

class RegencySuccess extends RegencyState {
  final RegencyModel regencyModel;

  RegencySuccess(this.regencyModel);
}

class RegencyError extends RegencyState {
  final String error;

  RegencyError(this.error);
}

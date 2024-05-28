import 'package:testing/domain/models/province_model.dart';

abstract class ProvinceState {}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceSuccess extends ProvinceState {
  final ProvinceModel provinceModel;

  ProvinceSuccess(this.provinceModel);
}

class ProvinceError extends ProvinceState {
  final String error;

  ProvinceError(this.error);
}

import 'package:testing/domain/models/district_model.dart';

abstract class DistrictState {}

class DistrictInitial extends DistrictState {}

class DistrictLoading extends DistrictState {}

class DistrictSuccess extends DistrictState {
  final DistrictModel districtModel;

  DistrictSuccess(this.districtModel);
}

class DistrictError extends DistrictState {
  final String error;

  DistrictError(this.error);
}

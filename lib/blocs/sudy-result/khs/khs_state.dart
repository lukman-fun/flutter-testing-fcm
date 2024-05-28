import 'package:testing/domain/models/khs_model.dart';

abstract class KhsState {}

class KhsInitial extends KhsState {}

class KhsLoading extends KhsState {}

class KhsSuccess extends KhsState {
  final KhsModel khsModel;

  KhsSuccess(this.khsModel);
}

class KhsError extends KhsState {
  final String error;

  KhsError(this.error);
}

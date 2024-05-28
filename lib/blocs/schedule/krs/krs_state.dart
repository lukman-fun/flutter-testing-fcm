import 'package:testing/domain/models/krs_model.dart';

abstract class KrsState {}

class KrsInitial extends KrsState {}

class KrsLoading extends KrsState {}

class KrsSuccess extends KrsState {
  final KrsModel krsModel;

  KrsSuccess(this.krsModel);
}

class KrsError extends KrsState {
  final String error;

  KrsError(this.error);
}

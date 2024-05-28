import 'package:testing/domain/models/kbm_model.dart';

abstract class KbmState {}

class KbmInitial extends KbmState {}

class KbmLoading extends KbmState {}

class KbmSuccess extends KbmState {
  final KbmModel kbmModel;

  KbmSuccess(this.kbmModel);
}

class KbmError extends KbmState {
  final String error;

  KbmError(this.error);
}

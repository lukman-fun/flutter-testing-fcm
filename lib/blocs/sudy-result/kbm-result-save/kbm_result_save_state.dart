import 'package:testing/domain/models/student_result_kbm.dart';
import 'package:testing/domain/models/success_model.dart';

abstract class KbmResultSaveState {}

class KbmResultSaveInitial extends KbmResultSaveState {}

class KbmResultSaveLoading extends KbmResultSaveState {}

class KbmResultSaveSuccess extends KbmResultSaveState {
  final SuccessModel successModel;

  KbmResultSaveSuccess(this.successModel);
}

class KbmResultSaveError extends KbmResultSaveState {
  final String error;

  KbmResultSaveError(this.error);
}

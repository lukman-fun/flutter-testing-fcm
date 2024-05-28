import 'package:testing/domain/models/student_result_kbm.dart';
import 'package:testing/domain/models/success_model.dart';

abstract class KbmResultState {}

class KbmResultInitial extends KbmResultState {}

class KbmResultLoading extends KbmResultState {}

class KbmResultSuccess extends KbmResultState {
  final StudentResultKbmModel studentResultKbmModel;

  KbmResultSuccess(this.studentResultKbmModel);
}

class KbmResultError extends KbmResultState {
  final String error;

  KbmResultError(this.error);
}

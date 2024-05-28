import 'package:testing/domain/models/teacher_kbm_model.dart';

abstract class TeacherKbmState {}

class TeacherKbmInitial extends TeacherKbmState {}

class TeacherKbmLoading extends TeacherKbmState {}

class TeacherKbmSuccess extends TeacherKbmState {
  final TeacherKbmModel teacherKbmModel;

  TeacherKbmSuccess(this.teacherKbmModel);
}

class TeacherKbmError extends TeacherKbmState {
  final String error;

  TeacherKbmError(this.error);
}

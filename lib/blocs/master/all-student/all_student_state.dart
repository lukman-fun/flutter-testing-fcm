import 'package:testing/domain/models/all_student_model.dart';

abstract class AllStudentState {}

class AllStudentInitial extends AllStudentState {}

class AllStudentLoading extends AllStudentState {}

class AllStudentSuccess extends AllStudentState {
  final AllStudentModel allStudentModel;

  AllStudentSuccess(this.allStudentModel);
}

class AllStudentError extends AllStudentState {
  final String error;

  AllStudentError(this.error);
}

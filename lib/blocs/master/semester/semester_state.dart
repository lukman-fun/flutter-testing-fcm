import 'package:testing/domain/models/semester_model.dart';

abstract class SemesterState {}

class SemesterInitial extends SemesterState {}

class SemesterLoading extends SemesterState {}

class SemesterSuccess extends SemesterState {
  final SemesterModel semesterModel;

  SemesterSuccess(this.semesterModel);
}

class SemesterError extends SemesterState {
  final String error;

  SemesterError(this.error);
}

import 'package:testing/domain/models/all_student_classes.dart';

abstract class AllStudentClassesState {}

class AllStudentClassesInitial extends AllStudentClassesState {}

class AllStudentClassesLoading extends AllStudentClassesState {}

class AllStudentClassesSuccess extends AllStudentClassesState {
  final AllStudentClassesModel allStudentClassesModel;

  AllStudentClassesSuccess(this.allStudentClassesModel);
}

class AllStudentClassesError extends AllStudentClassesState {
  final String error;

  AllStudentClassesError(this.error);
}

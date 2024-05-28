import 'package:testing/domain/models/teacher_classes_model.dart';

abstract class TeacherClassesState {}

class TeacherClassesInitial extends TeacherClassesState {}

class TeacherClassesLoading extends TeacherClassesState {}

class TeacherClassesSuccess extends TeacherClassesState {
  final TeacherClassesModel teacherClassesModel;

  TeacherClassesSuccess(this.teacherClassesModel);
}

class TeacherClassesError extends TeacherClassesState {
  final String error;

  TeacherClassesError(this.error);
}

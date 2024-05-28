import 'package:testing/domain/models/classes_model.dart';

abstract class ClassesState {}

class ClassesInitial extends ClassesState {}

class ClassesLoading extends ClassesState {}

class ClassesSuccess extends ClassesState {
  final ClassesModel classesModel;

  ClassesSuccess(this.classesModel);
}

class ClassesError extends ClassesState {
  final String error;

  ClassesError(this.error);
}

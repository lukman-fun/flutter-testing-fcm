import 'package:testing/domain/models/study_year_model.dart';

abstract class StudyYearState {}

class StudyYearInitial extends StudyYearState {}

class StudyYearLoading extends StudyYearState {}

class StudyYearSuccess extends StudyYearState {
  final StudyYearModel studyYearModel;

  StudyYearSuccess(this.studyYearModel);
}

class StudyYearError extends StudyYearState {
  final String error;

  StudyYearError(this.error);
}

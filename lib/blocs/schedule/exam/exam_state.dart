import 'package:testing/domain/models/exam_model.dart';

abstract class ExamState {}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamSuccess extends ExamState {
  final ExamModel examModel;

  ExamSuccess(this.examModel);
}

class ExamError extends ExamState {
  final String error;

  ExamError(this.error);
}

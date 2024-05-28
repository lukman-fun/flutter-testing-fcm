import 'package:testing/domain/models/student_report_model.dart';

abstract class StudentReportState {}

class StudentReportInitial extends StudentReportState {}

class StudentReportLoading extends StudentReportState {}

class StudentReportSuccess extends StudentReportState {
  final StudentReportModel studentReportModel;

  StudentReportSuccess(this.studentReportModel);
}

class StudentReportError extends StudentReportState {
  final String error;

  StudentReportError(this.error);
}

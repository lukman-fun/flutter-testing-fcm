abstract class StudentReportEvent {}

class OnGetStudentReport extends StudentReportEvent {
  final String? parentId;

  OnGetStudentReport(this.parentId);
}

abstract class KbmResultEvent {}

class OnGetKbmResult extends KbmResultEvent {
  final String semesterId;
  final String classesId;
  final String studentId;
  final String studyYearId;

  OnGetKbmResult(
    this.semesterId,
    this.classesId,
    this.studentId,
    this.studyYearId,
  );
}
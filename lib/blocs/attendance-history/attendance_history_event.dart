abstract class AttendanceHistoryEvent {}

class OnGetAttendanceHistory extends AttendanceHistoryEvent {
  final String? studyYearId;
  final String? semesterId;
  final String? classesId;
  final String? parentId;

  OnGetAttendanceHistory(
    this.studyYearId,
    this.semesterId,
    this.classesId,
    this.parentId,
  );
}

import 'package:testing/domain/models/attendance_history.dart';

abstract class AttendanceHistoryState {}

class AttendanceHistoryInitial extends AttendanceHistoryState {}

class AttendanceHistoryLoading extends AttendanceHistoryState {}

class AttendanceHistorySuccess extends AttendanceHistoryState {
  final AttendanceHistoryModel attendanceHistoryModel;

  AttendanceHistorySuccess(this.attendanceHistoryModel);
}

class AttendanceHistoryError extends AttendanceHistoryState {
  final String error;

  AttendanceHistoryError(this.error);
}

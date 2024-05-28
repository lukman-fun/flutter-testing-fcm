import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/attendance-history/attendance_history_event.dart';
import 'package:testing/blocs/attendance-history/attendance_history_state.dart';
import 'package:testing/domain/repositories/attendance_repository.dart';

class AttendanceHistoryBloc
    extends Bloc<AttendanceHistoryEvent, AttendanceHistoryState> {
  AttendanceHistoryBloc() : super(AttendanceHistoryInitial()) {
    on(_mapGetAttendanceHistory);
  }

  _mapGetAttendanceHistory(event, emit) async {
    emit(AttendanceHistoryLoading());
    try {
      final data = await AttendanceRepository().get(
        event.studyYearId,
        event.classesId,
        event.semesterId,
        event.parentId,
      );
      emit(AttendanceHistorySuccess(data));
    } catch (e) {
      emit(AttendanceHistoryError(e.toString()));
    }
  }
}

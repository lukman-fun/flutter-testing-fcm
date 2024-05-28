import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/student-report/student_report_event.dart';
import 'package:testing/blocs/student-report/student_report_state.dart';
import 'package:testing/domain/repositories/student_report_repository.dart';

class StudentReportBloc extends Bloc<StudentReportEvent, StudentReportState> {
  StudentReportBloc() : super(StudentReportInitial()) {
    on<OnGetStudentReport>(_mapGetStudentReport);
  }

  _mapGetStudentReport(event, emit) async {
    emit(StudentReportLoading());
    try {
      final data = await StudentReportRepository().get(event.parentId);

      emit(StudentReportSuccess(data));
    } catch (e) {
      emit(StudentReportError(e.toString()));
    }
  }
}

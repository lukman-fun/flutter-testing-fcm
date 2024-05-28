import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/master/all-student/all_student_event.dart';
import 'package:testing/blocs/master/all-student/all_student_state.dart';
import 'package:testing/domain/repositories/master_repository.dart';

class AllStudentBloc extends Bloc<AllStudentEvent, AllStudentState> {
  AllStudentBloc() : super(AllStudentInitial()) {
    on<OnGetAllStudent>(_mapGetAllStudent);
  }

  _mapGetAllStudent(event, emit) async {
    emit(AllStudentLoading());
    try {
      final data = await MasterRepository().all_student();

      emit(AllStudentSuccess(data));
    } catch (e) {
      emit(AllStudentError(e.toString()));
    }
  }
}

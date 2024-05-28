import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/schedule/teacher-kbm/kbm_event.dart';
import 'package:testing/blocs/schedule/teacher-kbm/kbm_state.dart';
import 'package:testing/domain/repositories/schedule_repository.dart';

class TeacherKbmBloc extends Bloc<TeacherKbmEvent, TeacherKbmState> {
  TeacherKbmBloc() : super(TeacherKbmInitial()) {
    on<OnGetTeacherKbm>(_mapGetTeacherKbm);
  }

  _mapGetTeacherKbm(event, emit) async {
    emit(TeacherKbmLoading());
    try {
      final data = await ScheduleRepository().teacher_kbm(event.day);

      emit(TeacherKbmSuccess(data));
    } catch (e) {
      emit(TeacherKbmError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/schedule/exam/exam_event.dart';
import 'package:testing/blocs/schedule/exam/exam_state.dart';
import 'package:testing/domain/repositories/schedule_repository.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  ExamBloc() : super(ExamInitial()) {
    on<OnGetExam>(_mapGetExam);
  }

  _mapGetExam(event, emit) async {
    emit(ExamLoading());
    try {
      final data = await ScheduleRepository().exam(event.parentId);

      emit(ExamSuccess(data));
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }
}

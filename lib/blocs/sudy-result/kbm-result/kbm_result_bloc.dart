import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/sudy-result/kbm-result/kbm_result_event.dart';
import 'package:testing/blocs/sudy-result/kbm-result/kbm_result_state.dart';
import 'package:testing/domain/repositories/study_result_repository.dart';

class KbmResultBloc extends Bloc<KbmResultEvent, KbmResultState> {
  KbmResultBloc() : super(KbmResultInitial()) {
    on<OnGetKbmResult>(_mapGetKbmResult);
  }

  _mapGetKbmResult(event, emit) async {
    emit(KbmResultLoading());
    try {
      final data = await StudyResultRepository().kbm_schedule(
        event.semesterId,
        event.classesId,
        event.studentId,
        event.studyYearId,
      );

      emit(KbmResultSuccess(data));
    } catch (e) {
      emit(KbmResultError(e.toString()));
    }
  }
}

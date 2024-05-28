import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/sudy-result/kbm-result-save/kbm_result_save_event.dart';
import 'package:testing/blocs/sudy-result/kbm-result-save/kbm_result_save_state.dart';
import 'package:testing/domain/repositories/study_result_repository.dart';

class KbmResultSaveBloc extends Bloc<KbmResultSaveEvent, KbmResultSaveState> {
  KbmResultSaveBloc() : super(KbmResultSaveInitial()) {
    on<OnSaveKbmResultSave>(_mapSaveKbmResultSave);
  }

  _mapSaveKbmResultSave(event, emit) async {
    emit(KbmResultSaveLoading());
    try {
      final data = await StudyResultRepository().save_kbm_result(event.body);

      emit(KbmResultSaveSuccess(data));
    } catch (e) {
      emit(KbmResultSaveError(e.toString()));
    }
  }
}

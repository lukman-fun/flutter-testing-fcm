import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/sudy-result/khs/khs_event.dart';
import 'package:testing/blocs/sudy-result/khs/khs_state.dart';
import 'package:testing/domain/repositories/study_result_repository.dart';

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  KhsBloc() : super(KhsInitial()) {
    on<OnGetKhs>(_mapGetKhs);
  }

  _mapGetKhs(event, emit) async {
    emit(KhsLoading());
    try {
      final data = await StudyResultRepository()
          .khs(event.classId, event.semesterId, event.parentId);

      emit(KhsSuccess(data));
    } catch (e) {
      emit(KhsError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/schedule/kbm/kbm_event.dart';
import 'package:testing/blocs/schedule/kbm/kbm_state.dart';
import 'package:testing/domain/repositories/schedule_repository.dart';

class KbmBloc extends Bloc<KbmEvent, KbmState> {
  KbmBloc() : super(KbmInitial()) {
    on<OnGetKbm>(_mapGetKbm);
  }

  _mapGetKbm(event, emit) async {
    emit(KbmLoading());
    try {
      final data = await ScheduleRepository().kbm(event.day, event.parentId);

      emit(KbmSuccess(data));
    } catch (e) {
      emit(KbmError(e.toString()));
    }
  }
}

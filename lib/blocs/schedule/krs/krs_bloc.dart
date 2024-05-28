import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/schedule/krs/krs_event.dart';
import 'package:testing/blocs/schedule/krs/krs_state.dart';
import 'package:testing/domain/repositories/schedule_repository.dart';

class KrsBloc extends Bloc<KrsEvent, KrsState> {
  KrsBloc() : super(KrsInitial()) {
    on<OnGetKrs>(_mapGetKrs);
  }

  _mapGetKrs(event, emit) async {
    emit(KrsLoading());
    try {
      final data = await ScheduleRepository().krs(event.parentId);

      emit(KrsSuccess(data));
    } catch (e) {
      emit(KrsError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/indonesia-area/regency/regency_event.dart';
import 'package:testing/blocs/indonesia-area/regency/regency_state.dart';
import 'package:testing/domain/repositories/indonesia_area_repository.dart';

class RegencyBloc extends Bloc<RegencyEvent, RegencyState> {
  RegencyBloc() : super(RegencyInitial()) {
    on<OnGetRegency>(_mapGetRegency);
  }

  _mapGetRegency(event, emit) async {
    emit(RegencyLoading());
    try {
      final data = await IndonesiaAreaRepository().regency(event.provinceId);

      emit(RegencySuccess(data));
    } catch (e) {
      emit(RegencyError(e.toString()));
    }
  }
}

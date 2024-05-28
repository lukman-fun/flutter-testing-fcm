import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/indonesia-area/province/province_event.dart';
import 'package:testing/blocs/indonesia-area/province/province_state.dart';
import 'package:testing/domain/repositories/indonesia_area_repository.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  ProvinceBloc() : super(ProvinceInitial()) {
    on<OnGetProvince>(_mapGetProvince);
  }

  _mapGetProvince(event, emit) async {
    emit(ProvinceLoading());
    try {
      final data = await IndonesiaAreaRepository().province();

      emit(ProvinceSuccess(data));
    } catch (e) {
      emit(ProvinceError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/indonesia-area/district/district_event.dart';
import 'package:testing/blocs/indonesia-area/district/district_state.dart';
import 'package:testing/domain/repositories/indonesia_area_repository.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  DistrictBloc() : super(DistrictInitial()) {
    on<OnGetDistrict>(_mapGetDistrict);
  }

  _mapGetDistrict(event, emit) async {
    emit(DistrictLoading());
    try {
      final data = await IndonesiaAreaRepository().district(event.regencyId);

      emit(DistrictSuccess(data));
    } catch (e) {
      emit(DistrictError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/indonesia-area/village/village_event.dart';
import 'package:testing/blocs/indonesia-area/village/village_state.dart';
import 'package:testing/domain/repositories/indonesia_area_repository.dart';

class VillageBloc extends Bloc<VillageEvent, VillageState> {
  VillageBloc() : super(VillageInitial()) {
    on<OnGetVillage>(_mapGetVillage);
  }

  _mapGetVillage(event, emit) async {
    emit(VillageLoading());
    try {
      final data = await IndonesiaAreaRepository().village(event.districtId);

      emit(VillageSuccess(data));
    } catch (e) {
      emit(VillageError(e.toString()));
    }
  }
}

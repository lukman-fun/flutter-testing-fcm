import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/master/semester/semester_event.dart';
import 'package:testing/blocs/master/semester/semester_state.dart';
import 'package:testing/domain/repositories/master_repository.dart';

class SemesterBloc extends Bloc<SemesterEvent, SemesterState> {
  SemesterBloc() : super(SemesterInitial()) {
    on<OnGetSemester>(_mapGetSemester);
  }

  _mapGetSemester(event, emit) async {
    emit(SemesterLoading());
    try {
      final data = await MasterRepository().semester();

      emit(SemesterSuccess(data));
    } catch (e) {
      emit(SemesterError(e.toString()));
    }
  }
}

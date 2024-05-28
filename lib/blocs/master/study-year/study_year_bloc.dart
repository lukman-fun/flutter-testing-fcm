import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/master/study-year/study_year_event.dart';
import 'package:testing/blocs/master/study-year/study_year_state.dart';
import 'package:testing/domain/repositories/master_repository.dart';

class StudyYearBloc extends Bloc<StudyYearEvent, StudyYearState> {
  StudyYearBloc() : super(StudyYearInitial()) {
    on<OnGetStudyYear>(_mapGetStudyYear);
  }

  _mapGetStudyYear(event, emit) async {
    emit(StudyYearLoading());
    try {
      final data = await MasterRepository().study_year();

      emit(StudyYearSuccess(data));
    } catch (e) {
      emit(StudyYearError(e.toString()));
    }
  }
}

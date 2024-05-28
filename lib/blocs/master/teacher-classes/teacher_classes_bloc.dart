import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/master/teacher-classes/teacher_classes_event.dart';
import 'package:testing/blocs/master/teacher-classes/teacher_classes_state.dart';
import 'package:testing/domain/repositories/master_repository.dart';

class TeacherClassesBloc
    extends Bloc<TeacherClassesEvent, TeacherClassesState> {
  TeacherClassesBloc() : super(TeacherClassesInitial()) {
    on<OnGetTeacherClasses>(_mapGetTeacherClasses);
  }

  _mapGetTeacherClasses(event, emit) async {
    emit(TeacherClassesLoading());
    try {
      final data = await MasterRepository()
          .teacher_classes(event.semester, event.studyYear);
      emit(TeacherClassesSuccess(data));
    } catch (e) {
      emit(TeacherClassesError(e.toString()));
    }
  }
}

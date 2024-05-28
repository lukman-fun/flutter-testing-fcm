import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/master/all-student-classes/all_student_classes_event.dart';
import 'package:testing/blocs/master/all-student-classes/all_student_classes_state.dart';
import 'package:testing/domain/repositories/master_repository.dart';

class AllStudentClassesBloc
    extends Bloc<AllStudentClassesEvent, AllStudentClassesState> {
  AllStudentClassesBloc() : super(AllStudentClassesInitial()) {
    on<OnGetAllStudentClasses>(_mapGetAllStudentClasses);
  }

  _mapGetAllStudentClasses(event, emit) async {
    emit(AllStudentClassesLoading());
    try {
      final data = await MasterRepository()
          .all_student_classes(event.classes, event.studyYear);

      emit(AllStudentClassesSuccess(data));
    } catch (e) {
      emit(AllStudentClassesError(e.toString()));
    }
  }
}

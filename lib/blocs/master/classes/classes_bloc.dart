import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/master/classes/classes_event.dart';
import 'package:testing/blocs/master/classes/classes_state.dart';
import 'package:testing/domain/repositories/master_repository.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  ClassesBloc() : super(ClassesInitial()) {
    on<OnGetClasses>(_mapGetClasses);
  }

  _mapGetClasses(event, emit) async {
    emit(ClassesLoading());
    try {
      final data = await MasterRepository().classes(event.parentId);

      emit(ClassesSuccess(data));
    } catch (e) {
      emit(ClassesError(e.toString()));
    }
  }
}

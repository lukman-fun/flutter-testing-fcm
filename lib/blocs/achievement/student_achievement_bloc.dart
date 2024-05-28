import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/achievement/student_achievement_event.dart';
import 'package:testing/blocs/achievement/student_achievement_state.dart';
import 'package:testing/domain/repositories/achievement_repository.dart';

class StudentAchievementBloc
    extends Bloc<StudentAchievementEvent, StudentAchievementState> {
  StudentAchievementBloc() : super(StudentAchievementInitial()) {
    on<OnGetStudentAchievement>(_mapGetStudentAchievement);
  }

  _mapGetStudentAchievement(event, emit) async {
    emit(StudentAchievementLoading());
    try {
      final data = await AchievementRepository()
          .student_achievement(event.type, event.parentId);

      emit(StudentAchievementSuccess(data));
    } catch (e) {
      emit(StudentAchievementError(e.toString()));
    }
  }
}

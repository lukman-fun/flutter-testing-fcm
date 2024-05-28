import 'package:testing/domain/models/student_achievement_model.dart';

abstract class StudentAchievementState {}

class StudentAchievementInitial extends StudentAchievementState {}

class StudentAchievementLoading extends StudentAchievementState {}

class StudentAchievementSuccess extends StudentAchievementState {
  final StudentAchievementModel studentAchievementModel;

  StudentAchievementSuccess(this.studentAchievementModel);
}

class StudentAchievementError extends StudentAchievementState {
  final String error;

  StudentAchievementError(this.error);
}

abstract class StudentAchievementEvent {}

class OnGetStudentAchievement extends StudentAchievementEvent {
  final String type;
  final String? parentId;

  OnGetStudentAchievement(this.type, this.parentId);
}

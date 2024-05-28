abstract class TeacherClassesEvent {}

class OnGetTeacherClasses extends TeacherClassesEvent {
  final String? semester;
  final String? studyYear;

  OnGetTeacherClasses(this.semester, this.studyYear);
}

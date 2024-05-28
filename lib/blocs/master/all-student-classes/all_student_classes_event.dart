abstract class AllStudentClassesEvent {}

class OnGetAllStudentClasses extends AllStudentClassesEvent {
  final String? classes;
  final String? studyYear;

  OnGetAllStudentClasses(this.classes, this.studyYear);
}

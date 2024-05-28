abstract class ClassesEvent {}

class OnGetClasses extends ClassesEvent {
  final String? parentId;

  OnGetClasses(this.parentId);
}

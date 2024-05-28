abstract class TeacherKbmEvent {}

class OnGetTeacherKbm extends TeacherKbmEvent {
  final String day;

  OnGetTeacherKbm(this.day);
}

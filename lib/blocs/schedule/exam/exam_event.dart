abstract class ExamEvent {}

class OnGetExam extends ExamEvent {
  final String? parentId;

  OnGetExam(this.parentId);
}

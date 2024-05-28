abstract class KhsEvent {}

class OnGetKhs extends KhsEvent {
  final String? classId;
  final String? semesterId;
  final String? parentId;

  OnGetKhs(this.classId, this.semesterId, this.parentId);
}

abstract class KrsEvent {}

class OnGetKrs extends KrsEvent {
  final String? parentId;

  OnGetKrs(this.parentId);
}

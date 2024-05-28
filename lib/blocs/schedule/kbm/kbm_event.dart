abstract class KbmEvent {}

class OnGetKbm extends KbmEvent {
  final String day;
  final String? parentId;

  OnGetKbm(this.day, this.parentId);
}

abstract class KbmResultSaveEvent {}

class OnSaveKbmResultSave extends KbmResultSaveEvent {
  final Map<String, dynamic> body;

  OnSaveKbmResultSave(this.body);
}

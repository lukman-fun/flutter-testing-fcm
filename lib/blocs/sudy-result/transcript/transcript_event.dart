abstract class TranscriptEvent {}

class OnGetTranscript extends TranscriptEvent {
  final String? parentId;

  OnGetTranscript(this.parentId);
}

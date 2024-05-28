import 'package:testing/domain/models/transcript_model.dart';

abstract class TranscriptState {}

class TranscriptInitial extends TranscriptState {}

class TranscriptLoading extends TranscriptState {}

class TranscriptSuccess extends TranscriptState {
  final TranscriptModel transcriptModel;

  TranscriptSuccess(this.transcriptModel);
}

class TranscriptError extends TranscriptState {
  final String error;

  TranscriptError(this.error);
}

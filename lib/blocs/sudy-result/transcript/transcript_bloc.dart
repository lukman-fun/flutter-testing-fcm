import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/sudy-result/transcript/transcript_event.dart';
import 'package:testing/blocs/sudy-result/transcript/transcript_state.dart';
import 'package:testing/domain/repositories/study_result_repository.dart';

class TranscriptBloc extends Bloc<TranscriptEvent, TranscriptState> {
  TranscriptBloc() : super(TranscriptInitial()) {
    on<OnGetTranscript>(_mapGetTranscript);
  }

  _mapGetTranscript(event, emit) async {
    emit(TranscriptLoading());
    try {
      final data = await StudyResultRepository().transcript(event.parentId);

      emit(TranscriptSuccess(data));
    } catch (e) {
      emit(TranscriptError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/archive-file/archive_file_event.dart';
import 'package:testing/blocs/archive-file/archive_file_state.dart';
import 'package:testing/domain/repositories/archive_repository.dart';

class ArchiveFileBloc extends Bloc<ArchiveFileEvent, ArchiveFileState> {
  ArchiveFileBloc() : super(ArchiveFileInitial()) {
    on<OnGetArchiveFile>(_mapGetArchiveFile);
  }

  _mapGetArchiveFile(event, emit) async {
    emit(ArchiveFileLoading());
    try {
      final data = await ArchiveRepository().archive_file();

      emit(ArchiveFileSuccess(data));
    } catch (e) {
      emit(ArchiveFileError(e.toString()));
    }
  }
}

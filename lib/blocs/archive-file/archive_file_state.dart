import 'package:testing/domain/models/archive_file.dart';

abstract class ArchiveFileState {}

class ArchiveFileInitial extends ArchiveFileState {}

class ArchiveFileLoading extends ArchiveFileState {}

class ArchiveFileSuccess extends ArchiveFileState {
  final ArchiveFileModel archiveFileModel;

  ArchiveFileSuccess(this.archiveFileModel);
}

class ArchiveFileError extends ArchiveFileState {
  final String error;

  ArchiveFileError(this.error);
}

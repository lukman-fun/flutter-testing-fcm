import 'package:testing/domain/models/academic_announcement_model.dart';

abstract class AcademicAnnouncementState {}

class AcademicAnnouncementInitial extends AcademicAnnouncementState {}

class AcademicAnnouncementLoading extends AcademicAnnouncementState {}

class AcademicAnnouncementSuccess extends AcademicAnnouncementState {
  final AcademicAnnouncementModel academicAnnouncementModel;

  AcademicAnnouncementSuccess(this.academicAnnouncementModel);
}

class AcademicAnnouncementError extends AcademicAnnouncementState {
  final String error;

  AcademicAnnouncementError(this.error);
}

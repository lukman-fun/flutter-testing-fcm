import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/schedule/academic_announcement/academic_announcement_event.dart';
import 'package:testing/blocs/schedule/academic_announcement/academic_announcement_state.dart';
import 'package:testing/domain/repositories/schedule_repository.dart';

class AcademicAnnouncementBloc
    extends Bloc<AcademicAnnouncementEvent, AcademicAnnouncementState> {
  AcademicAnnouncementBloc() : super(AcademicAnnouncementInitial()) {
    on<OnGetAcademicAnnouncement>(_mapGetAcademicAnnouncement);
  }

  _mapGetAcademicAnnouncement(event, emit) async {
    emit(AcademicAnnouncementInitial());
    try {
      final data = await ScheduleRepository().academic_announcement();

      emit(AcademicAnnouncementSuccess(data));
    } catch (e) {
      emit(AcademicAnnouncementError(e.toString()));
    }
  }
}

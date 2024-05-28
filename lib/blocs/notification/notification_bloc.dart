import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/notification/notification_event.dart';
import 'package:testing/blocs/notification/notification_state.dart';
import 'package:testing/domain/repositories/notification_repository.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<OnGetNotification>(_mapGetNotification);
  }

  _mapGetNotification(event, emit) async {
    emit(NotificationLoading());
    try {
      final data = await NotificationRepository().notification();

      emit(NotificationSuccess(data));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}

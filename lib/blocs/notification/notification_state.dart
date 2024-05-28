import 'package:testing/domain/models/notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final NotificationModel notificationModel;

  NotificationSuccess(this.notificationModel);
}

class NotificationError extends NotificationState {
  final String error;

  NotificationError(this.error);
}

part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

final class GetNotificationsEvent extends NotificationEvent {}

final class CreateNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;
  const CreateNotificationEvent(this.notification);

  @override
  List<Object?> get props => [notification];
}

final class UpdateNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;
  const UpdateNotificationEvent(this.notification);

  @override
  List<Object?> get props => [notification];
}

class DeleteNotificationEvent extends NotificationEvent {
  final String id;
  const DeleteNotificationEvent(this.id);

  @override
  List<Object?> get props => [id];
}

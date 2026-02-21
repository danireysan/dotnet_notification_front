part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

final class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<ResultNotificationEntity> notifications;
  const NotificationLoaded(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class DeleteNotificationSuccess extends NotificationState {}

class UpdateNotificationSuccess extends NotificationState {}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}

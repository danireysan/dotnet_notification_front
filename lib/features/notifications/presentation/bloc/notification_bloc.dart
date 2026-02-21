import 'dart:async';
import 'dart:developer';

import 'package:dotnet_notification_front/features/notifications/domain/entities/result_notification_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/error/failure.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repository/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;

  NotificationBloc({required this.repository}) : super(NotificationInitial()) {
    on<GetNotificationsEvent>(_onGetNotifications);
    on<CreateNotificationEvent>(_onCreateNotification);
    on<UpdateNotificationEvent>(_onUpdateNofitication);
    on<DeleteNotificationEvent>(_onDeleteNotification);
  }

  Future<void> _onGetNotifications(
    GetNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    final result = await repository.getAll();

    result.fold(
      (failure) => emit(NotificationError(_mapFailureToMessage(failure))),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }

  Future<void> _onCreateNotification(
    CreateNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    final result = await repository.create(event.notification);

    result.fold(
      (failure) => emit(NotificationError(_mapFailureToMessage(failure))),
      (_) => add(GetNotificationsEvent()), // Refresh list on success
    );
  }

  FutureOr<void> _onUpdateNofitication(
    UpdateNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    final result = await repository.update(event.notification);

    result.fold(
      (failure) => emit(NotificationError(_mapFailureToMessage(failure))),
      (_) {
        emit(UpdateNotificationSuccess());
        add(GetNotificationsEvent());
      },
    );
  }

  Future<void> _onDeleteNotification(
    DeleteNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    final result = await repository.delete(event.id);

    result.fold(
      (failure) => emit(NotificationError(_mapFailureToMessage(failure))),
      (_) {
        emit(DeleteNotificationSuccess());
        add(GetNotificationsEvent());
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Your standard error mapping logic
    return failure.message;
  }

  @override
  void onChange(Change<NotificationState> change) {
    log(
      'NotificationBloc state changed: ${change.currentState} -> ${change.nextState}',
    );
    super.onChange(change);
  }
}

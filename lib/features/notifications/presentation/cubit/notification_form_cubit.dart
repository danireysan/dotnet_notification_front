import 'package:dotnet_notification_front/features/notifications/domain/entities/push_token_value_object.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/email_value_object.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_type.dart';
import '../../domain/entities/phone_value_object.dart';
import 'notification_form_state.dart';

class NotificationFormCubit extends Cubit<NotificationFormState> {
  NotificationFormCubit() : super(NotificationFormState.initial());

  void reset() => emit(NotificationFormState.initial());

  void titleChanged(String val) => emit(state.copyWith(title: val));

  void contentChanged(String val) => emit(state.copyWith(content: val));

  void typeChanged(NotificationType type) =>
      emit(state.copyWith(selectedType: type));

  void emailChanged(String val) =>
      emit(state.copyWith(emailResult: Email.create(val)));

  void phoneChanged(String val) =>
      emit(state.copyWith(phoneResult: PhoneNumber.create(val)));

  void pushTokenChanged(String val) =>
      emit(state.copyWith(pushToken: PushTokenValueObject.create(val)));

  /// Converts the current state into the appropriate Entity
  NotificationEntity? getEntity() {
    if (!state.isValid) return null;

    switch (state.selectedType) {
      case NotificationType.email:
        return EmailNotificationEntity(
          title: state.title,
          content: state.content,
          email: state.email!,
        );
      case NotificationType.sms:
        return SmsNotificationEntity(
          title: state.title,
          content: state.content,
          sms: state.phone!,
        );
      case NotificationType.push:
        return PushNotificationEntity(
          title: state.title,
          content: state.content,
          pushToken: state.pushTokenValue!,
        );
    }
  }
}

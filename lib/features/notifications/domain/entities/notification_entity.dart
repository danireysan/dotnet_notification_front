import 'package:dotnet_notification_front/core/domain/entities/email_value_object.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/phone_value_object.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/push_token_value_object.dart';

import 'notification_type.dart';

sealed class NotificationEntity {
  final String? id;
  final NotificationType type;
  final String title;
  final String content;

  const NotificationEntity({
    this.id,
    required this.type,
    required this.title,
    required this.content,
  });
}

class EmailNotificationEntity extends NotificationEntity {
  final Email email;
  EmailNotificationEntity({
    super.id,
    required super.title,
    required super.content,
    required this.email,
  }) : super(type: NotificationType.email);
}

class SmsNotificationEntity extends NotificationEntity {
  final PhoneNumber sms;
  SmsNotificationEntity({
    super.id,
    required super.title,
    required super.content,
    required this.sms,
  }) : super(type: NotificationType.sms);
}

class PushNotificationEntity extends NotificationEntity {
  final PushTokenValueObject pushToken;
  PushNotificationEntity({
    super.id,
    required super.title,
    required super.content,
    required this.pushToken,
  }) : super(type: NotificationType.push);
}

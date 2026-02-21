import 'package:dotnet_notification_front/features/notifications/domain/entities/notification_type.dart';

class ResultNotificationEntity {
  final String id;
  final String title;
  final String content;
  final String recipient;
  final NotificationType type;
  final String sentAt;

  const ResultNotificationEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.recipient,
    required this.type,
    required this.sentAt,
  });
}

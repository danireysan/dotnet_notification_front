import 'package:dotnet_notification_front/features/notifications/domain/entities/result_notification_entity.dart';

import '../../domain/entities/notification_type.dart';

class ResultNotificationModel extends ResultNotificationEntity {
  ResultNotificationModel({
    required super.id,
    required super.title,
    required super.content,
    required super.recipient,
    required super.type,
    required super.sentAt,
  });

  factory ResultNotificationModel.fromJson(Map<String, dynamic> json) {
    return ResultNotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      recipient: json['recipient'] as String,
      type:
          NotificationType.fromString((json['type'] as String).toLowerCase()) ??
          NotificationType.email,
      sentAt: json['sentAt'] as String,
    );
  }

  // from list
  static List<ResultNotificationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map(
          (json) =>
              ResultNotificationModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}

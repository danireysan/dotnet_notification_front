import 'package:dotnet_notification_front/features/notifications/domain/entities/result_notification_entity.dart';

class ResultNotificationModel extends ResultNotificationEntity {
  ResultNotificationModel({
    required super.id,
    required super.title,
    required super.content,
    required super.recipient,
  });

  factory ResultNotificationModel.fromJson(Map<String, dynamic> json) {
    return ResultNotificationModel(
      id: json['Id'] as String,
      title: json['Title'] as String,
      content: json['Content'] as String,
      recipient: json['Recipient'] as String,
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

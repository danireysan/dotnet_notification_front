import '../../domain/entities/notification_entity.dart';

class NotificationRequestModel {
  final String? id;
  final String type;
  final String title;
  final String content;
  final String? email;
  final String? sms;
  final String? push;

  NotificationRequestModel({
    this.id,
    required this.type,
    required this.title,
    required this.content,
    this.email,
    this.sms,
    this.push,
  });

  factory NotificationRequestModel.fromEntity(NotificationEntity entity) {
    return switch (entity) {
      EmailNotificationEntity e => NotificationRequestModel(
        id: e.id,
        type: e.type.value,
        title: e.title,
        content: e.content,
        email: e.email.value,
      ),
      SmsNotificationEntity s => NotificationRequestModel(
        id: s.id,
        type: s.type.value,
        title: s.title,
        content: s.content,
        sms: s.sms.value,
      ),
      PushNotificationEntity p => NotificationRequestModel(
        id: p.id,
        type: p.type.value,
        title: p.title,
        content: p.content,
        push: p.pushToken.value,
      ),
    };
  }

  /// Converts the model to a PascalCase Map for the .NET Backend
  Map<String, dynamic> toJson() {
    return {
      'Type': type,
      'Title': title,
      'Content': content,
      if (id != null) 'Id': id,
      if (email != null) 'Email': email,
      if (sms != null) 'Sms': sms,
      if (push != null) 'DeviceId': push,
    };
  }
}

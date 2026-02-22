import 'package:dotnet_notification_front/features/notifications/domain/repository/local_notification_repository.dart';

import '../../domain/repository/push_notification_repository.dart';

class NotificationService {
  final PushNotificationRepository _repository;
  final LocalNotificationRepository _localNotifications; // New service

  NotificationService(this._repository, this._localNotifications);

  void initialize() {
    // Listen for foreground messages
    _repository.onNotificationReceived.listen((notification) {
      // Manually trigger a local popup because the OS won't do it automatically
      _localNotifications.show(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000, // Unique ID
        title: notification.title ?? "New Update",
        body: notification.body ?? "",
        payload: notification.data,
      );
    });
  }
}

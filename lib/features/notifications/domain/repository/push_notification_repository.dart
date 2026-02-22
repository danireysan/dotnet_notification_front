import 'package:dotnet_notification_front/features/notifications/domain/entities/push_notification.dart';

abstract class PushNotificationRepository {
  // Existing token methods...
  Future<String?> getToken();
  Stream<String> get onTokenRefresh;

  Stream<PushNotificationEntity> get onNotificationReceived;

  Stream<PushNotificationEntity> get onNotificationOpened;
}

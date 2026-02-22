import 'package:dotnet_notification_front/features/notifications/domain/repository/push_notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../domain/entities/push_notification.dart';

class FirebasePushNotificationRepository implements PushNotificationRepository {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  Stream<PushNotificationEntity> get onNotificationReceived =>
      FirebaseMessaging.onMessage.map(_mapToDomain);

  @override
  Stream<PushNotificationEntity> get onNotificationOpened =>
      FirebaseMessaging.onMessageOpenedApp.map(_mapToDomain);

  PushNotificationEntity _mapToDomain(RemoteMessage message) {
    return PushNotificationEntity(
      title: message.notification?.title,
      body: message.notification?.body,
      data: message.data,
    );
  }

  // Reuse your previous token implementations here...
  @override
  Future<String?> getToken() => _fcm.getToken();

  @override
  Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;
}

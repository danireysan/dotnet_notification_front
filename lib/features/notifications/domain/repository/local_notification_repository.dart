abstract class LocalNotificationRepository {
  Future<void> initialize();

  Future<void> show({
    required int id,
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  });
}

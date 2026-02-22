class PushNotificationEntity {
  final String? title;
  final String? body;
  final Map<String, dynamic> data;

  PushNotificationEntity({this.title, this.body, this.data = const {}});
}

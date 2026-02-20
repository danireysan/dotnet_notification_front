enum NotificationType {
  email('email'),
  sms('sms'),
  push('push');

  final String value;
  const NotificationType(this.value);
}

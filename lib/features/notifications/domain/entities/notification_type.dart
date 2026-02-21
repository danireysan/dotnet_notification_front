enum NotificationType {
  email('email'),
  sms('sms'),
  push('push');

  final String value;
  const NotificationType(this.value);

  static NotificationType? fromString(String value) {
    for (var type in NotificationType.values) {
      if (type.value == value) {
        return type;
      }
    }
    return null; // Return null if no match is found
  }
}

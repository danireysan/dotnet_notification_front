import 'package:flutter/material.dart';

class MinimalistNotificationTile extends StatelessWidget {
  final String title;
  final String message;
  final String recipient;

  const MinimalistNotificationTile({
    super.key,
    required this.title,
    required this.message,
    required this.recipient,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: ListTile(
        leading: const Icon(Icons.notifications, color: Colors.black),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(message, style: TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text(
              'To: $recipient',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      ),
    );
  }
}

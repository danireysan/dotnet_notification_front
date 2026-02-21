import 'package:flutter/material.dart';

class DeleteNotificationDialog extends StatelessWidget {
  final String title;

  const DeleteNotificationDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF6F6F6), // Off-white background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Consistent organic rounding
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bold header matching the "Log in" style
            const Text(
              'Delete Notification?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Are you sure you want to delete "$title"? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),

            // Primary Destructive Action (Solid Black)
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Delete'),
            ),

            const SizedBox(height: 8),

            // Secondary Action (Text only/Grey)
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF9E9E9E), // Grey from input hint style
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

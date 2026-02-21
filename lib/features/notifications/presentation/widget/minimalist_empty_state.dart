import 'package:flutter/material.dart';

class MinimalistEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  const MinimalistEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.onActionPressed,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.inbox_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF9E9E9E),
                height: 1.5,
              ),
            ),
            if (onActionPressed != null && actionLabel != null) ...[
              const SizedBox(height: 32),
              // Reusing the "Continue" button style
              ElevatedButton(
                onPressed: onActionPressed,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

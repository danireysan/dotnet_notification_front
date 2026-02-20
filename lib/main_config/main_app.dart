import 'package:dotnet_notification_front/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AuthPage());
  }
}

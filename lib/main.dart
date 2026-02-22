import 'package:dotnet_notification_front/core/instances/core_instances.dart';
import 'package:dotnet_notification_front/features/notifications/instances/notifications_instances.dart';
import 'package:dotnet_notification_front/main_config/main_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/di/inject_all_dependencies.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await injectAllDependencies();

  // Notifications setup
  await localNotificationRepository.initialize();
  notificationService.initialize();

  apiClient.healthCheck();
  runApp(const MainApp());
}

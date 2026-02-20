import 'package:dotnet_notification_front/core/instances/core_instances.dart';
import 'package:dotnet_notification_front/main_config/main_app.dart';
import 'package:flutter/material.dart';

import 'core/di/inject_all_dependencies.dart';

Future<void> main() async {
  await injectAllDependencies();

  apiClient.healthCheck();
  runApp(const MainApp());
}

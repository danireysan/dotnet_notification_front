import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/di/inject_auth_dependencies.dart';
import '../../features/notifications/di/inject_notifications_dependencies.dart';
import 'inject_core_dependencies.dart';

final getIt = GetIt.instance;

Future<void> injectAllDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.pushNewScope();

  await injectCoreDependencies();
  await injectAuthDependencies();
  await injectNotificationDependencies();
}

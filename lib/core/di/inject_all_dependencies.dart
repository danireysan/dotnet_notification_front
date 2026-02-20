import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'inject_core_dependencies.dart';

final getIt = GetIt.instance;

Future<void> injectAllDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.pushNewScope();

  await injectCoreDependencies();
}

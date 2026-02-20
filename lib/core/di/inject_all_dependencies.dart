import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> injectAllDependencies() async {
  getIt.pushNewScope();
}

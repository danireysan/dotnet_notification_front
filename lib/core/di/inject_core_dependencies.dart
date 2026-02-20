import '../network/server_api_client.dart';
import 'inject_all_dependencies.dart';

Future<void> injectCoreDependencies() async {
  getIt.registerSingleton<ApiClient>(ApiClient());
}

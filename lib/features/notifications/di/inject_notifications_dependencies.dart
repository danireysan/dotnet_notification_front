import 'package:dotnet_notification_front/features/notifications/data/services/notification_service.dart';
import 'package:dotnet_notification_front/features/notifications/domain/repository/push_notification_repository.dart';

import '../../../core/di/inject_all_dependencies.dart';
import '../data/repository/local_notifications_repository_impl.dart';
import '../data/repository/notification_repository_impl.dart';
import '../data/repository/push_notification_repository_impl.dart';
import '../data/repository/push_token_repository_impl.dart';
import '../domain/repository/local_notification_repository.dart';
import '../domain/repository/notification_repository.dart';
import '../domain/repository/push_token_repository.dart';
import '../presentation/bloc/notification_bloc.dart';
import '../presentation/cubit/notification_form_cubit.dart';

Future<void> injectNotificationDependencies() async {
  // Repositories
  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(apiClient: getIt()),
  );

  // Blocs
  getIt.registerFactory<NotificationBloc>(
    () => NotificationBloc(repository: getIt()),
  );

  getIt.registerFactory<NotificationFormCubit>(() => NotificationFormCubit());

  getIt.registerFactory<PushTokenRepository>(
    () => FirebasePushTokenRepository(),
  );

  getIt.registerFactory<LocalNotificationRepository>(
    () => FlutterLocalNotificationService(),
  );

  getIt.registerLazySingleton<PushNotificationRepository>(
    () => FirebasePushNotificationRepository(),
  );

  getIt.registerLazySingleton(() => NotificationService(getIt(), getIt()));
}

import '../../../core/di/inject_all_dependencies.dart';
import '../data/repository/notification_repository_impl.dart';
import '../domain/repository/notification_repository.dart';
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
}

import 'package:dotnet_notification_front/features/notifications/presentation/cubit/notification_form_cubit.dart';

import '../../../core/di/inject_all_dependencies.dart';
import '../data/services/notification_service.dart';
import '../domain/repository/local_notification_repository.dart';
import '../domain/repository/push_notification_repository.dart';
import '../domain/repository/push_token_repository.dart'
    show PushTokenRepository;
import '../presentation/bloc/notification_bloc.dart' show NotificationBloc;

final notificationsBloc = getIt<NotificationBloc>();
final notificationFormCubit = getIt<NotificationFormCubit>();

final localNotificationRepository = getIt<LocalNotificationRepository>();
final notificationService = getIt<NotificationService>();
final pushNotificationRepository = getIt<PushNotificationRepository>();
final tokenRepository = getIt<PushTokenRepository>();

import 'package:dotnet_notification_front/features/notifications/presentation/cubit/notification_form_cubit.dart';

import '../../../core/di/inject_all_dependencies.dart';
import '../presentation/bloc/notification_bloc.dart' show NotificationBloc;

final notificationsBloc = getIt<NotificationBloc>();
final notificationFormCubit = getIt<NotificationFormCubit>();

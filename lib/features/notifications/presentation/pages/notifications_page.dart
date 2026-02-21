import 'package:dotnet_notification_front/core/presentation/widgets/progress_hud.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/notification_entity.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/result_notification_entity.dart';
import 'package:dotnet_notification_front/features/notifications/instances/notifications_instances.dart';
import 'package:dotnet_notification_front/features/notifications/presentation/widget/create_notification_dialog.dart';
import 'package:dotnet_notification_front/features/notifications/presentation/widget/minimalist_empty_state.dart'
    show MinimalistEmptyState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notification_bloc.dart';
import '../widget/minimalist_notification_tile.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<ResultNotificationEntity> notifications = [];

  @override
  void initState() {
    notificationsBloc.add(GetNotificationsEvent());
    super.initState();
  }

  Future<void> openCreateNotificationDialog() async {
    final result = await showDialog<NotificationEntity>(
      context: context,
      builder: (context) => const CreateNotificationDialog(),
    );

    if (result != null) {
      notificationsBloc.add(CreateNotificationEvent(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider.value(value: notificationsBloc)],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<NotificationBloc, NotificationState>(
            listener: (context, state) {
              if (state is NotificationLoaded) {
                setState(() {
                  notifications = state.notifications;
                });
              }

              if (state is NotificationError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (notifications.isEmpty) {
                return MinimalistEmptyState(
                  title: 'No Notifications',
                  subtitle: 'You have no notifications at the moment.',
                  actionLabel: 'Create a Notification',
                  onActionPressed: openCreateNotificationDialog,
                );
              }
              return ProgressHUD(
                inAsyncCall: state is NotificationLoading,
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return MinimalistNotificationTile(
                      title: notification.title,
                      message: notification.content,
                      recipient: notification.recipient,
                    );
                  },
                ),
              );
            },
          ),
        ),
        floatingActionButton: notifications.isEmpty
            ? null
            : FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: openCreateNotificationDialog,
                child: const Icon(Icons.add, color: Colors.white),
              ),
      ),
    );
  }
}

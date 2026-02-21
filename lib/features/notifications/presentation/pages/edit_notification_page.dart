import 'package:dotnet_notification_front/core/presentation/widgets/progress_hud.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/notification_type.dart';
import 'package:dotnet_notification_front/features/notifications/instances/notifications_instances.dart';
import 'package:dotnet_notification_front/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:dotnet_notification_front/features/notifications/presentation/cubit/notification_form_cubit.dart';
import 'package:dotnet_notification_front/features/notifications/presentation/cubit/notification_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/delete_notification_dialog.dart';

class EditNotificationPage extends StatefulWidget {
  final String id;
  final String title;
  final String content;
  final String recipient;
  final NotificationType type;

  const EditNotificationPage({
    super.key,
    required this.title,
    required this.id,
    required this.content,
    required this.recipient,
    required this.type,
  });

  @override
  State<EditNotificationPage> createState() => _EditNotificationPageState();
}

class _EditNotificationPageState extends State<EditNotificationPage> {
  @override
  void initState() {
    super.initState();
    notificationFormCubit.reset();
    notificationFormCubit.titleChanged(widget.title);
    notificationFormCubit.contentChanged(widget.content);
    switch (widget.type) {
      case NotificationType.email:
        notificationFormCubit.emailChanged(widget.recipient);
        break;
      case NotificationType.sms:
        notificationFormCubit.phoneChanged(widget.recipient);
        break;
      case NotificationType.push:
        notificationFormCubit.pushTokenChanged(widget.recipient);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: notificationsBloc),
        BlocProvider.value(value: notificationFormCubit),
      ],
      child: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state is DeleteNotificationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Notification deleted successfully"),
              ),
            );
            Navigator.pop(context);
          }
          if (state is UpdateNotificationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Notification updated successfully"),
              ),
            );
          }
          if (state is NotificationError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, notificationState) {
          return BlocBuilder<NotificationFormCubit, NotificationFormState>(
            builder: (context, formState) {
              return ProgressHUD(
                inAsyncCall: notificationState is NotificationLoading,
                child: Scaffold(
                  backgroundColor: const Color(0xFFF6F6F6),
                  appBar: AppBar(
                    centerTitle: true,
                    leading: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Text("Notification Details"),
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        _buildFieldLabel("NOTIFICATION TITLE"),
                        TextFormField(
                          initialValue: widget.title,
                          onChanged: (value) =>
                              notificationFormCubit.titleChanged(value),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            hintText: "Untitled",
                            errorText: formState.titleError,
                          ),
                        ),
                        const SizedBox(height: 24),

                        _buildFieldLabel("CONTENT"),
                        TextFormField(
                          initialValue: widget.content,

                          onChanged: (value) =>
                              notificationFormCubit.contentChanged(value),
                          maxLines: 5,
                          decoration: InputDecoration(
                            errorText: formState.contentError,
                            hintText: "Write your message...",
                          ),
                        ),
                        const SizedBox(height: 24),

                        _buildFieldLabel(
                          "${widget.type.name.toUpperCase()} RECIPIENT",
                        ),
                        Visibility(
                          visible: widget.type != NotificationType.push,
                          child: TextFormField(
                            initialValue: widget.recipient,
                            onChanged: (value) {
                              switch (widget.type) {
                                case NotificationType.email:
                                  notificationFormCubit.emailChanged(value);
                                  break;
                                case NotificationType.sms:
                                  notificationFormCubit.phoneChanged(value);
                                  break;
                                case NotificationType.push:
                                  notificationFormCubit.pushTokenChanged(value);
                                  break;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: _getHintText(),
                              errorText: formState.selectedTypeErrorMessage,
                              prefixIcon: Icon(
                                _getIcon(),
                                size: 20,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        ElevatedButton(
                          onPressed: formState.isValid
                              ? () {
                                  notificationFormCubit.idChanged(widget.id);
                                  final entity = notificationFormCubit
                                      .getEntity();
                                  if (entity != null && entity.id != null) {
                                    notificationsBloc.add(
                                      UpdateNotificationEvent(entity),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please fix the errors in the form",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              : null,
                          child: const Text("Update Notification"),
                        ),
                        SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () async {
                            final shouldDelete = await showDialog(
                              context: context,
                              builder: (context) =>
                                  DeleteNotificationDialog(title: widget.title),
                            );

                            if (shouldDelete == true) {
                              notificationsBloc.add(
                                DeleteNotificationEvent(widget.id),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          label: const Text(
                            "Delete Notification",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.black.withValues(alpha: .4),
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  String _getHintText() {
    switch (widget.type) {
      case NotificationType.email:
        return "name@example.com";
      case NotificationType.sms:
        return "+1 234 ...";
      default:
        return "Device token...";
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case NotificationType.email:
        return Icons.alternate_email;
      case NotificationType.sms:
        return Icons.phone_android;
      default:
        return Icons.sensors;
    }
  }
}

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
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _recipientController;

  @override
  void initState() {
    super.initState();
    notificationFormCubit.reset();
    notificationFormCubit.idChanged(widget.id);
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
    _recipientController = TextEditingController(text: widget.recipient);

    // listener
    _titleController.addListener(() {
      notificationFormCubit.titleChanged(_titleController.text);
    });
    _contentController.addListener(() {
      notificationFormCubit.contentChanged(_contentController.text);
    });
    _recipientController.addListener(() {
      switch (widget.type) {
        case NotificationType.email:
          notificationFormCubit.emailChanged(_recipientController.text);
          break;
        case NotificationType.sms:
          notificationFormCubit.phoneChanged(_recipientController.text);
          break;
        case NotificationType.push:
          notificationFormCubit.pushTokenChanged(_recipientController.text);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is DeleteNotificationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Notification deleted successfully")),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, notificationState) {
        return BlocBuilder<NotificationFormCubit, NotificationFormState>(
          builder: (context, formState) {
            return Scaffold(
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
                    TextField(
                      controller: _titleController,
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
                    TextField(
                      controller: _contentController,
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
                      child: TextField(
                        controller: _recipientController,
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
                              final entity = notificationFormCubit.getEntity();
                              if (entity != null) {
                                notificationsBloc.add(
                                  UpdateNotificationEvent(entity),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Notification updated successfully",
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
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      label: const Text(
                        "Delete Notification",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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

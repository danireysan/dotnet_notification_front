import 'package:animate_do/animate_do.dart';
import 'package:dotnet_notification_front/features/notifications/instances/notifications_instances.dart';
import 'package:dotnet_notification_front/features/notifications/presentation/cubit/notification_form_cubit.dart';
import 'package:dotnet_notification_front/features/notifications/presentation/cubit/notification_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/notification_type.dart';

class CreateNotificationDialog extends StatefulWidget {
  const CreateNotificationDialog({super.key});

  @override
  State<CreateNotificationDialog> createState() =>
      _CreateNotificationDialogState();
}

class _CreateNotificationDialogState extends State<CreateNotificationDialog> {
  NotificationType _selectedType = NotificationType.email;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _extraController = TextEditingController();

  @override
  void initState() {
    super.initState();
    notificationFormCubit.reset();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUpBig(
      duration: const Duration(milliseconds: 250),
      child: Dialog(
        backgroundColor: const Color(0xFFF6F6F6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        insetPadding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: BlocProvider.value(
            value: notificationFormCubit,
            child: BlocBuilder<NotificationFormCubit, NotificationFormState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'New Notification',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Minimalist Type Selector
                    _buildTypeSelector(),

                    const SizedBox(height: 20),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        errorText: state.titleError,
                      ),
                      onChanged: (value) =>
                          notificationFormCubit.titleChanged(value),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _contentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Content',
                        errorText: state.contentError,
                      ),
                      onChanged: (value) =>
                          notificationFormCubit.contentChanged(value),
                    ),
                    const SizedBox(height: 12),

                    // Dynamic field based on type
                    Visibility(
                      visible: !(_selectedType == NotificationType.push),
                      child: TextField(
                        controller: _extraController,
                        decoration: InputDecoration(
                          hintText: _selectedType == NotificationType.email
                              ? 'Email Address'
                              : 'Phone Number',

                          errorText: state.selectedTypeErrorMessage,
                        ),

                        onChanged: (value) {
                          if (_selectedType == NotificationType.email) {
                            notificationFormCubit.emailChanged(value);
                          } else {
                            notificationFormCubit.phoneChanged(value);
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: state.isValid ? _submit : null,
                      child: const Text('Create'),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: NotificationType.values.map((type) {
          bool isSelected = _selectedType == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedType = type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    type.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _submit() {
    final entity = notificationFormCubit.getEntity();
    if (entity != null) {
      Navigator.pop(context, entity); // Return the created entity to the caller
    }
  }
}

import 'package:dotnet_notification_front/features/notifications/domain/entities/push_token_value_object.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/entities/email_value_object.dart';
import '../../../../core/domain/error/failure.dart';
import '../../domain/entities/notification_type.dart';
import '../../domain/entities/phone_value_object.dart';

class NotificationFormState extends Equatable {
  final bool isEditing;
  final String id;
  final String title;
  final String content;
  final NotificationType selectedType;

  // Specific inputs
  final Either<Failure, Email> emailResult;
  final Either<Failure, PhoneNumber> phoneResult;
  final Either<Failure, PushTokenValueObject> pushToken;

  const NotificationFormState({
    required this.id,
    required this.isEditing,
    required this.title,
    required this.content,
    required this.selectedType,
    required this.emailResult,
    required this.phoneResult,
    required this.pushToken,
  });

  factory NotificationFormState.initial() => NotificationFormState(
    isEditing: false,
    id: '',
    title: '',
    content: '',
    selectedType: NotificationType.email,
    emailResult: Email.create(''),
    phoneResult: PhoneNumber.create(''),
    pushToken: PushTokenValueObject.create(''),
  );

  // Validation Logic
  bool get isTitleValid => title.trim().isNotEmpty;
  bool get isContentValid => content.trim().isNotEmpty;
  String? get titleError => isTitleValid ? null : 'Title cannot be empty';
  String? get contentError => isContentValid ? null : 'Content cannot be empty';

  bool get isSpecificInputValid {
    switch (selectedType) {
      case NotificationType.email:
        return emailResult.isRight();
      case NotificationType.sms:
        return phoneResult.isRight();
      case NotificationType.push:
        return pushToken.isRight();
    }
  }

  bool get isValid => isTitleValid && isContentValid && isSpecificInputValid;
  Email? get email => emailResult.getRight().toNullable();
  PhoneNumber? get phone => phoneResult.getRight().toNullable();
  PushTokenValueObject? get pushTokenValue => pushToken.getRight().toNullable();

  String? get selectedTypeErrorMessage {
    switch (selectedType) {
      case NotificationType.email:
        return emailResult.getLeft().toNullable()?.message;
      case NotificationType.sms:
        return phoneResult.getLeft().toNullable()?.message;
      case NotificationType.push:
        return pushToken.getLeft().toNullable()?.message;
    }
  }

  NotificationFormState copyWith({
    String? id,
    bool? isEditing,
    String? title,
    String? content,
    NotificationType? selectedType,
    Either<Failure, Email>? emailResult,
    Either<Failure, PhoneNumber>? phoneResult,
    Either<Failure, PushTokenValueObject>? pushToken,
  }) {
    return NotificationFormState(
      id: id ?? this.id,
      isEditing: isEditing ?? this.isEditing,
      title: title ?? this.title,
      content: content ?? this.content,
      selectedType: selectedType ?? this.selectedType,
      emailResult: emailResult ?? this.emailResult,
      phoneResult: phoneResult ?? this.phoneResult,
      pushToken: pushToken ?? this.pushToken,
    );
  }

  @override
  List<Object> get props => [
    title,
    id,
    isEditing,
    content,
    selectedType,
    emailResult,
    phoneResult,
    pushToken,
  ];
}

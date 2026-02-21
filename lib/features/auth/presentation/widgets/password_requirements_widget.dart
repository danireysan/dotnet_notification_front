import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_form_cubit.dart';

class PasswordRequirementsWidget extends StatelessWidget {
  const PasswordRequirementsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      builder: (context, state) {
        final failure = state.passwordFailure;

        final bool isClean = failure == null;

        return Column(
          spacing: 4,
          children: [
            _requirementItem(
              "One lowercase letter",
              failure?.hasLowercase ?? isClean,
            ),
            _requirementItem(
              "One uppercase letter",
              failure?.hasUppercase ?? isClean,
            ),
            _requirementItem("One number", failure?.hasDigits ?? isClean),
            _requirementItem(
              "One special character",
              failure?.hasSpecial ?? isClean,
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: (failure?.metCount ?? (isClean ? 4 : 0)) / 4,
              color: isClean ? Colors.green : Colors.orange,
            ),
          ],
        );
      },
    );
  }

  Widget _requirementItem(String label, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.close,
          color: isMet ? Colors.green : Colors.red,
        ),
        SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

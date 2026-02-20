import 'package:animate_do/animate_do.dart';
import 'package:dotnet_notification_front/features/auth/presentation/cubit/login_form_cubit.dart';
import 'package:dotnet_notification_front/features/auth/presentation/widgets/password_field.dart';
import 'package:dotnet_notification_front/features/auth/presentation/widgets/password_requirements_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../instances/auth_instances.dart';
import '../bloc/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: loginFormCubit),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthSuccess) {
            // Handle successful authentication, e.g., navigate to the home page
          }
        },
        child: Scaffold(body: FadeIn(child: _AuthForm())),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  const _AuthForm();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDownBig(
                delay: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.grey,
                ),
              ), // Placeholder for logo
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: state.emailFailureMessage,
                ),
                onChanged: (value) => loginFormCubit.emailChanged(value),
              ),
              PasswordField(
                onChanged: (value) {
                  loginFormCubit.passwordChanged(value);
                },
              ),

              if (state.passwordFailure != null) PasswordRequirementsWidget(),
              FadeInLeft(
                child: ElevatedButton(
                  onPressed: state.authRequestEntity == null
                      ? null
                      : () {
                          authBloc.add(AuthRequest(state.authRequestEntity!));
                        },
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:dotnet_notification_front/features/auth/presentation/cubit/login_form_cubit.dart';
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
        listener: (context, state) {},
        child: BlocBuilder<LoginFormCubit, LoginFormState>(
          builder: (context, state) {
            return Scaffold(body: Column(children: []));
          },
        ),
      ),
    );
  }
}

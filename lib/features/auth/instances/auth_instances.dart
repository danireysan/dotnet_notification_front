import '../../../core/di/inject_all_dependencies.dart';
import '../presentation/bloc/auth_bloc.dart';
import '../presentation/cubit/login_form_cubit.dart';

final authBloc = getIt<AuthBloc>();
final loginFormCubit = getIt<LoginFormCubit>();

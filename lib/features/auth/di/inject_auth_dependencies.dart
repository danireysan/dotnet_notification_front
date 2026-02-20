import '../../../core/di/inject_all_dependencies.dart';
import '../data/repository/auth_repository_impl.dart';
import '../domain/repository/auth_repository.dart';
import '../presentation/bloc/auth_bloc.dart';
import '../presentation/cubit/login_form_cubit.dart';

Future<void> injectAuthDependencies() async {
  getIt.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(apiClient: getIt()),
  );

  getIt.registerFactory(() => LoginFormCubit());

  getIt.registerFactory(() => AuthBloc(repository: getIt()));
}

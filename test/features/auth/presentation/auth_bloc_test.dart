import 'package:bloc_test/bloc_test.dart';
import 'package:dotnet_notification_front/features/auth/presentation/cubit/login_form_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LoginFormCubit loginFormCubit;

  setUp(() {
    loginFormCubit = LoginFormCubit();
  });

  tearDown(() {
    loginFormCubit.close();
  });

  group('LoginFormCubit', () {
    test('initial state is LoginFormState.initial()', () {
      expect(loginFormCubit.state, LoginFormState.initial());
    });

    blocTest<LoginFormCubit, LoginFormState>(
      'emits state with updated emailResult when emailChanged is called',
      build: () => loginFormCubit,
      act: (cubit) => cubit.emailChanged('test@example.com'),
      verify: (cubit) {
        // Check if the email result is now "Right" (valid)
        expect(cubit.state.emailResult.isRight(), isTrue);
      },
    );

    blocTest<LoginFormCubit, LoginFormState>(
      'emits state with updated passwordResult when passwordChanged is called',
      build: () => loginFormCubit,
      act: (cubit) => cubit.passwordChanged('password123'),
      verify: (cubit) {
        expect(cubit.state.passwordResult.isRight(), isTrue);
      },
    );

    blocTest<LoginFormCubit, LoginFormState>(
      'isValid should be true when both email and password are valid',
      build: () => loginFormCubit,
      act: (cubit) {
        cubit.emailChanged('valid@email.com');
        cubit.passwordChanged('validpassword');
      },
      expect: () => [
        // State 1: Email changed
        isA<LoginFormState>().having(
          (s) => s.emailResult.isRight(),
          'valid email',
          isTrue,
        ),
        // State 2: Password changed
        isA<LoginFormState>()
            .having((s) => s.passwordResult.isRight(), 'valid password', isTrue)
            .having((s) => s.isValid, 'form is valid', isTrue),
      ],
    );

    blocTest<LoginFormCubit, LoginFormState>(
      'isValid should be false if email is invalid',
      build: () => loginFormCubit,
      act: (cubit) => cubit.emailChanged('invalid-email'),
      verify: (cubit) {
        expect(cubit.state.isValid, isFalse);
        expect(cubit.state.emailFailure, isNotNull);
      },
    );
  });
}

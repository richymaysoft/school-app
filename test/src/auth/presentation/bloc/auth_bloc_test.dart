import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:school_app/src/auth/domain/usecases/forgot_password.dart';
import 'package:school_app/src/auth/domain/usecases/sign_in.dart';
import 'package:school_app/src/auth/domain/usecases/sign_up.dart';
import 'package:school_app/src/auth/domain/usecases/update_user.dart';
import 'package:school_app/src/auth/presentation/bloc/auth_bloc.dart';

class MockSignUp extends Mock implements SignUp {}

class MockSignIn extends Mock implements SignIn {}

class MockUpdateUser extends Mock implements UpdateUser {}

class MockForgotPassword extends Mock implements ForgotPassword {}

void main() {
  late SignUp signUp;
  late SignIn signIn;
  late UpdateUser updateUser;
  late ForgotPassword forgotPassword;
  late AuthBloc authBloc;

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    updateUser = MockUpdateUser();
    forgotPassword = MockForgotPassword();

    forgotPassword = MockForgotPassword();
    authBloc = AuthBloc(
        signUp: signUp,
        signIn: signIn,
        updateUser: updateUser,
        forgotPassword: forgotPassword);
  });

  const tSignUpParam = SignUpParams.empty();
  const tSignInParam = SignInParams.empty();

  setUpAll(() {
    registerFallbackValue(tSignUpParam);
  });

  tearDown(() => authBloc.close());

  test('Initial state', () {
    expect(authBloc.state, AuthInitial());
  });

  group('sign up', () {
    blocTest<AuthBloc, AuthState>(
      'emit [AuthLoadingState, SignedUpState] when sign up is '
      'successful',
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          SignUpEvent(
              email: tSignInParam.email,
              password: tSignUpParam.password,
              name: tSignUpParam.fullName),
        );
      },
      expect: () {
        return const [AuthLoadingState(), SignedUpState()];
      },
      verify: (bloc) {
        verify(
          () => signUp(tSignUpParam),
        ).called(1);
      },
    );
  });
}

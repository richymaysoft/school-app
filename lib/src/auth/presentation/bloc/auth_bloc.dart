import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_app/core/enums/what_to_update.dart';
import 'package:school_app/core/errors/failure.dart';
import 'package:school_app/src/auth/data/models/local_user_model.dart';
import 'package:school_app/src/auth/domain/usecases/forgot_password.dart';
import 'package:school_app/src/auth/domain/usecases/sign_in.dart';
import 'package:school_app/src/auth/domain/usecases/sign_up.dart';
import 'package:school_app/src/auth/domain/usecases/update_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignUp signUp,
    required SignIn signIn,
    required UpdateUser updateUser,
    required ForgotPassword forgotPassword,
  })  : _forgotPassword = forgotPassword,
        _signIn = signIn,
        _signUp = signUp,
        _updateUser = updateUser,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoadingState());
    });

    on<SignUpEvent>(_signUpHandler);
    on<SignInEvent>(_signInHandler);
  }

  final SignUp _signUp;
  final SignIn _signIn;
  final UpdateUser _updateUser;
  final ForgotPassword _forgotPassword;

  Future<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
        fullName: event.name,
      ),
    );
    result.fold(
      (failure) => null,
      (user) => emit(const SignedUpState()),
    );
  }

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => null,
      (user) => emit(SignedInState(user as LocalUserModel)),
    );
  }
}

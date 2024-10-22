part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class SignedUpState extends AuthState {
  const SignedUpState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthErrorState extends AuthState {
  const AuthErrorState(this.message);
  final String message;
}

class SignedInState extends AuthState {
  const SignedInState(this.localUser);
  final LocalUserModel localUser;
}

class PasswordUpdated extends AuthState {
  const PasswordUpdated();
}

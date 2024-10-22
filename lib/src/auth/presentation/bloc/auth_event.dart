// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  const SignInEvent({
    required this.email,
    required this.password,
  });
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  const SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}

class UpdateUserEvent extends AuthEvent {
  final WhatToUpdate event;
  final dynamic userData;
  UpdateUserEvent({
    required this.event,
    required this.userData,
  }) : assert(
          userData is String || userData is File,
          '[userData] must be a String or a File but it is a ${userData.runtimeType}',
        );
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  const ForgotPasswordEvent({
    required this.email,
  });
}

import 'package:school_app/core/enums/what_to_update.dart';
import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/auth/domain/entities/user.dart';

abstract class AuthRepos {
  AuthRepos();
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });
  ResultFuture<void> signUp(
      {required String name, required String email, required String password});
  ResultFuture<void> forgotPassword({required String email});
  ResultFuture<void> updateUser({
    required WhatToUpdate whatToUpdate,
    dynamic userData,
  });
}

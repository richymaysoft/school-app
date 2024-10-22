import 'package:dartz/dartz.dart';
import 'package:school_app/core/enums/what_to_update.dart';
import 'package:school_app/core/errors/exception.dart';
import 'package:school_app/core/errors/failure.dart';
import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/auth/data/datasource/datasource.dart';
import 'package:school_app/src/auth/domain/entities/user.dart';
import 'package:school_app/src/auth/domain/repos/auth_repos.dart';

class AuthReposImpl implements AuthRepos {
  AuthReposImpl(this._dataSource);
  final DataSource _dataSource;

  @override
  ResultFuture<void> forgotPassword({required String email}) async {
    try {
      await _dataSource.forgotPassword(email: email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _dataSource.signIn(email: email, password: password);
      return Right(result as LocalUser);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _dataSource.forgotPassword(
        email: email,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<void> updateUser({
    required WhatToUpdate whatToUpdate,
    dynamic userData,
  }) async {
    try {
      await _dataSource.updateUser(
        userData: userData,
        whatToUpdate: whatToUpdate,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }
}

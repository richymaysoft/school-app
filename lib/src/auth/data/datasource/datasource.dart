import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/core/enums/what_to_update.dart';
import 'package:school_app/core/errors/exception.dart';
import 'package:school_app/core/utils/constants.dart';
import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/auth/data/models/local_user_model.dart';
import 'package:school_app/src/auth/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DataSource {
  ResultFuture<void> forgotPassword({required String email});
  Future<LocalUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> updateUser({
    required WhatToUpdate whatToUpdate,
    dynamic userData,
  });
}

class RemoteDataSourceImpl implements DataSource {
  RemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
  })  : _authClient = firebaseAuth,
        _databaseClient = firebaseFirestore,
        _storageClient = firebaseStorage;
  final FirebaseAuth _authClient;
  final FirebaseFirestore _databaseClient;
  final FirebaseStorage _storageClient;

  @override
  ResultFuture<void> forgotPassword({required String email}) async {
    // TODO: implement forgotPassword

    try {
      await _authClient.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? 'An Error Occured', statusCode: 505);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    // TODO: implement signIn
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;

      if (user == null) {
        throw const ServerException(
          message: 'Error ocuured',
          statusCode: 'Unknown Error',
        );
      }
      var userData = await _getUser(user.uid);
      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }

      await _setUser(user, email);
      userData = await _getUser(user.uid);

      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? 'An Error Occured', statusCode: 505);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    // TODO: implement signUpflutterfire configure

    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCred.user?.updateDisplayName(name);
      await userCred.user?.updatePhotoURL(kDefaultAvatar);
      await _setUser(_authClient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? 'An Error Occured', statusCode: 505);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> updateUser({
    required WhatToUpdate whatToUpdate,
    dynamic userData,
  }) async {
    try {
      switch (whatToUpdate) {
        case WhatToUpdate.fullName:
          await _authClient.currentUser?.updateDisplayName(userData as String);
          await _databaseClient
              .collection('users')
              .doc(_authClient.currentUser!.uid)
              .set({'displayName': userData});
        case WhatToUpdate.email:
          await _authClient.currentUser
              ?.verifyBeforeUpdateEmail(userData as String);

        case WhatToUpdate.password:
          if (_authClient.currentUser?.email == null) {
            throw const ServerException(
              message: 'Error! Login again',
              statusCode: 505,
            );
          }
          final userPassword = jsonDecode(userData as String) as DataMap;
          await _authClient.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authClient.currentUser!.email!,
              password: userPassword['oldPassword'] as String,
            ),
          );

        case WhatToUpdate.profilepIC:
          final ref = _storageClient
              .ref()
              .child('profilePic/${_authClient.currentUser!.uid}');

          await ref.putFile(userData as File);
          final photoURL = await ref.getDownloadURL();
          await _authClient.currentUser!.updatePhotoURL(photoURL);

        case WhatToUpdate.bio:
          await _updateUserData({'bio': userData as String});
      }
    } on FirebaseException catch (e) {
      throw ServerException(
          message: e.message ?? 'An Error Occured', statusCode: 505);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUser(String uid) async {
    final result = await _databaseClient.collection('users').doc(uid).get();
    return result;
  }

  Future<void> _setUser(User user, String fallBackEmail) async {
    await _databaseClient.collection('users').doc(user.uid).set(
          LocalUserModel(
            fullName: user.displayName ?? '',
            email: user.email ?? '',
            profilePic: user.photoURL ?? '',
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _databaseClient
        .collection('users')
        .doc(_authClient.currentUser!.uid)
        .set(data);
  }
}

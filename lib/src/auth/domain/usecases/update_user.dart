import 'package:equatable/equatable.dart';
import 'package:school_app/core/enums/what_to_update.dart';
import 'package:school_app/core/usecases/usecases.dart';
import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/auth/domain/repos/auth_repos.dart';

class UpdateUser extends UsecaseWithParam<void, UpdateUserParams> {
  UpdateUser(this._authRepos);
  final AuthRepos _authRepos;

  @override
  ResultFuture<void> call(UpdateUserParams params) async =>
      _authRepos.updateUser(
        userData: params.userData,
        whatToUpdate: params.whatToUpdate,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.userData,
    required this.whatToUpdate,
  });

  const UpdateUserParams.empty()
      : this(
          userData: '',
          whatToUpdate: WhatToUpdate.bio,
        );

  final String userData;
  final WhatToUpdate whatToUpdate;

  @override
  List<Object> get props => [whatToUpdate, userData];
}

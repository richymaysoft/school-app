import 'package:equatable/equatable.dart';
import 'package:school_app/core/usecases/usecases.dart';
import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/auth/domain/entities/user.dart';
import 'package:school_app/src/auth/domain/repos/auth_repos.dart';

class SignIn extends UsecaseWithParam<LocalUser, SignInParams> {
  SignIn(this._authRepos);
  final AuthRepos _authRepos;

  @override
  ResultFuture<LocalUser> call(SignInParams params) async =>
      _authRepos.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  const SignInParams.empty()
      : this(
          email: 'email.empty',
          password: 'password.empty',
        );

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

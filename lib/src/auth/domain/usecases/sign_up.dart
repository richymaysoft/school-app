import 'package:equatable/equatable.dart';
import 'package:school_app/core/usecases/usecases.dart';
import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/auth/domain/repos/auth_repos.dart';

class SignIn extends UsecaseWithParam<void, SignUpParams> {
  SignIn(this._authRepos);
  final AuthRepos _authRepos;

  @override
  ResultFuture<void> call(SignUpParams params) async => _authRepos.signUp(
        email: params.email,
        password: params.password,
        name: params.fullName,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const SignUpParams.empty()
      : this(
          email: 'email.empty',
          fullName: 'fullname.empty',
          password: 'password.empty',
        );

  final String email;
  final String password;
  final String fullName;

  @override
  List<String> get props => [email, password];
}

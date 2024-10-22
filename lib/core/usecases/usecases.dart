import 'package:equatable/equatable.dart';
import 'package:school_app/core/utils/typedefs.dart';

abstract class UsecaseWithParam<T, Params> {
  UsecaseWithParam();
  ResultFuture<T> call(Params params);
}

abstract class UsecaseWithoutParam<Type> {
  UsecaseWithoutParam();
  ResultFuture<Type> call();
}

class UserParam extends Equatable {
  const UserParam({required this.name});
  final String name;

  @override
  List<dynamic> get props => [name];
}

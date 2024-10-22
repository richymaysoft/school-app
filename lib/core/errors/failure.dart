import 'package:equatable/equatable.dart';
import 'package:school_app/core/errors/exception.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode})
      : assert(
          statusCode is String || statusCode is int,
          'Sorry! statusCode must be a string or an integer',
        );
  final String message;
  final dynamic statusCode;

  String get errorMessage {
    return 'Error: $message $statusCode';
  }

  @override
  List<dynamic> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

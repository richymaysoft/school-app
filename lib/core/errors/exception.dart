import 'package:equatable/equatable.dart';

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message, this.statusCode = 500});
  final String message;
  final int statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});
  final String message;
  final dynamic statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}

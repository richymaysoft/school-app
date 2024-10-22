import 'package:dartz/dartz.dart';
import 'package:school_app/core/errors/failure.dart';

typedef ResultVoid = Future<Either<Failure, void>>;

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;

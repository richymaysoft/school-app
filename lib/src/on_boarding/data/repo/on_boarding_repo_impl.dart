import 'package:dartz/dartz.dart';
import 'package:school_app/core/errors/exception.dart';
import 'package:school_app/core/errors/failure.dart';
import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/on_boarding/data/datasource/local_data_source.dart';
import 'package:school_app/src/on_boarding/domain/repo/on_boarding_repo.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  OnBoardingRepoImpl(this._localDatasourec);
  final LocalDataSource _localDatasourec;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDatasourec.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDatasourec.chechIfFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }
}

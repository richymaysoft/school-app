import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_app/core/errors/exception.dart';
import 'package:school_app/core/errors/failure.dart';
import 'package:school_app/src/on_boarding/data/datasource/local_data_source.dart';
import 'package:school_app/src/on_boarding/data/repo/on_boarding_repo_impl.dart';

class MockLocalDataSource extends Mock implements LocalDataSource {}

void main() {
  late LocalDataSource localDataSourse;
  late OnBoardingRepoImpl repoImpl;

  setUp(() {
    localDataSourse = MockLocalDataSource();
    repoImpl = OnBoardingRepoImpl(localDataSourse);
  });

  test(
      'call [localDataSource.cachFirstTimer] and return null if '
      'successful', () async {
    // arrange
    when(() => localDataSourse.cacheFirstTimer())
        .thenAnswer((_) async => Future.value());
// act
    final result = await repoImpl.cacheFirstTimer();
    expect(result, equals(const Right<dynamic, void>(null)));
// assert
    verify(() => localDataSourse.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(localDataSourse);
  });

  test(
      'call [localDataSource.cachFirstTimer] and return CacheExcepton if '
      'failed', () async {
    // arrange
    when(() => localDataSourse.cacheFirstTimer()).thenThrow(
      const CacheException(
        message: 'failed to cache',
      ),
    );
// act
    final result = await repoImpl.cacheFirstTimer();
    expect(
      result,
      equals(
        const Left<CacheFailure, dynamic>(
          CacheFailure(
            message: 'failed to cache',
            statusCode: 500,
          ),
        ),
      ),
    );
// assert
    verify(() => localDataSourse.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(localDataSourse);
  });
}

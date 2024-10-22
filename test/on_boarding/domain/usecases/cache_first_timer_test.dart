import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_app/core/errors/failure.dart';
import 'package:school_app/src/on_boarding/domain/repo/on_boarding_repo.dart';
import 'package:school_app/src/on_boarding/domain/usecases/cache_first_timer.dart';

import '../../../mock_onboarding_repo.mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CacheFirstTimer usecase;

  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test(
      'Call the repo.cacheFirstTimer and return a null '
      'if the reuest is successful', () async {
    when(() => repo.cacheFirstTimer())
        .thenAnswer((_) async => const Right(null));

    final result = await usecase();
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repo.cacheFirstTimer(),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });

  test(
      'Call the repo.cacheFirstTimer and return a ServerException '
      'when the call fails', () async {
    when(() => repo.cacheFirstTimer()).thenAnswer(
      (_) async => const Left(
        ServerFailure(
          message: 'User not cached',
          statusCode: 500,
        ),
      ),
    );

    final result = await usecase();
    expect(
      result,
      equals(
        const Left<dynamic, Failure>(
          ServerFailure(
            message: 'User not cached',
            statusCode: 500,
          ),
        ),
      ),
    );
    verify(
      () => repo.cacheFirstTimer(),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_app/core/errors/failure.dart';
import 'package:school_app/src/on_boarding/domain/repo/on_boarding_repo.dart';
import 'package:school_app/src/on_boarding/domain/usecases/chech_if_first_timer.dart';

import '../../../mock_onboarding_repo.mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CheckIfFirstTimer usecase;

  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CheckIfFirstTimer(repo);
  });

  test(
      'Call the repo.checkIfFirstTimer and return a bool '
      'if the reuest is successful', () async {
    when(() => repo.checkIfUserIsFirstTimer())
        .thenAnswer((_) async => const Right(true));

    final result = await usecase();
    expect(result, equals(const Right<dynamic, bool>(true)));
    verify(
      () => repo.checkIfUserIsFirstTimer(),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });

  test(
      'Call the repo.cacheFirstTimer and return a ServerException '
      'when the call fails', () async {
    when(() => repo.checkIfUserIsFirstTimer()).thenAnswer(
      (_) async => const Left(
        ServerFailure(
          message: 'Failed to check',
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
            message: 'Failed to check',
            statusCode: 500,
          ),
        ),
      ),
    );
    verify(
      () => repo.checkIfUserIsFirstTimer(),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}

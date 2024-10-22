import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:school_app/src/on_boarding/domain/usecases/chech_if_first_timer.dart';
import 'package:school_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockChechIfFirstTimer extends Mock implements CheckIfFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfFirstTimer checkIfFirstTimer;
  late OnBoardingCubit cubit;

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfFirstTimer = MockChechIfFirstTimer();
    cubit = OnBoardingCubit(
      cacheFirstTimer: cacheFirstTimer,
      checkIfFirstTimer: checkIfFirstTimer,
    );
  });

  group('cacheFirstTimer', () {
    test('emit [OnBoardingInitialState] by default', () {
      expect(cubit.state, equals(OnBoardingInitial()));
    });

    blocTest<OnBoardingCubit, OnBoardingState>(
        'call cacheFirstTimer, emit[CachingFirstTimer, FirstTimerCached] '
        'when successful',
        build: () {
          when(() => cacheFirstTimer())
              .thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (cubit) => cubit.cachFirstTimer(),
        expect: () => const [CachingFirstTimer(), FirstTimerCached()],
        verify: (_) {
          verify(() => cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(cacheFirstTimer);
        });
  });
}

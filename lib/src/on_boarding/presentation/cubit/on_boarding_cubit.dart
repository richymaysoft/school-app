import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:school_app/src/on_boarding/domain/usecases/chech_if_first_timer.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfFirstTimer checkIfFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfFirstTimer = checkIfFirstTimer,
        super(OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfFirstTimer _checkIfFirstTimer;

  Future<void> cachFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimer();
    result.fold(
      (failure) => emit(ErrorState(failure.errorMessage)),
      (_) => emit(const FirstTimerCached()),
    );
  }

  Future<void> checkIfFirstTimer() async {
    emit(const CheckingFirstTimer());
    final result = await _checkIfFirstTimer();
    result.fold(
      (failure) => emit(const FirstTimerChecked(isFirstTimer: true)),
      (value) => emit(FirstTimerChecked(isFirstTimer: value)),
    );
  }
}

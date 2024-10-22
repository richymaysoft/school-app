part of 'on_boarding_cubit.dart';

sealed class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

final class OnBoardingInitial extends OnBoardingState {}

class CachingFirstTimer extends OnBoardingState {
  const CachingFirstTimer();
}

class FirstTimerCached extends OnBoardingState {
  const FirstTimerCached();
}

class CheckingFirstTimer extends OnBoardingState {
  const CheckingFirstTimer();
}

class FirstTimerChecked extends OnBoardingState {
  const FirstTimerChecked({required this.isFirstTimer});
  final bool isFirstTimer;

  @override
  List<bool> get props => [isFirstTimer];
}

class ErrorState extends OnBoardingState {
  const ErrorState(this.message);
  final String message;

  @override
  List<String> get props => [message];
}

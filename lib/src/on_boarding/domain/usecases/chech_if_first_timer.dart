import 'package:school_app/core/usecases/usecases.dart';
import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/on_boarding/domain/repo/on_boarding_repo.dart';

class CheckIfFirstTimer extends UsecaseWithoutParam<bool> {
  CheckIfFirstTimer(this._repo);
  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}

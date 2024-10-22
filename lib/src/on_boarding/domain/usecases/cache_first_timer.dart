import 'package:school_app/core/usecases/usecases.dart';
import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/on_boarding/domain/repo/on_boarding_repo.dart';

class CacheFirstTimer extends UsecaseWithoutParam<void> {
  CacheFirstTimer(this._cacheRepo);
  final OnBoardingRepo _cacheRepo;

  @override
  ResultFuture<void> call() async => _cacheRepo.cacheFirstTimer();
}

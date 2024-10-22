import 'package:get_it/get_it.dart';
import 'package:school_app/src/on_boarding/data/datasource/local_data_source.dart';
import 'package:school_app/src/on_boarding/data/repo/on_boarding_repo_impl.dart';
import 'package:school_app/src/on_boarding/domain/repo/on_boarding_repo.dart';
import 'package:school_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:school_app/src/on_boarding/domain/usecases/chech_if_first_timer.dart';
import 'package:school_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  // Feature --> OnBoarding
  // Business Logic
  sl
    ..registerFactory(
      () => OnBoardingCubit(cacheFirstTimer: sl(), checkIfFirstTimer: sl()),
    )
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepo>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton(() => prefs);
}

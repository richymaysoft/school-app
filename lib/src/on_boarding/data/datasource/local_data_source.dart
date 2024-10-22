import 'package:school_app/core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  LocalDataSource();
  Future<void> cacheFirstTimer();
  Future<bool> chechIfFirstTimer();
}

const kFirstTimerKey = 'first_timer';

class LocalDataSourceImpl extends LocalDataSource {
  LocalDataSourceImpl(this._pref);
  final SharedPreferences _pref;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _pref.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> chechIfFirstTimer() async {
    try {
      return _pref.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}

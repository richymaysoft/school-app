import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_app/core/errors/exception.dart';
import 'package:school_app/src/on_boarding/data/datasource/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MochSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences references;
  late LocalDataSourceImpl lacalSourceImpl;

  setUp(() {
    references = MochSharedPreferences();
    lacalSourceImpl = LocalDataSourceImpl(references);
  });

  group('CacheFirstTimer', () {
    test('cach successfully', () async {
      when(() => references.setBool(any(), any()))
          .thenAnswer((_) async => false);
      await lacalSourceImpl.cacheFirstTimer();
      verify(() => references.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(references);
    });
  });

  test('failed to cache', () async {
    when(() => references.setBool(any(), any())).thenThrow(Exception());
    final methodCall = lacalSourceImpl.cacheFirstTimer;
    expect(methodCall, throwsA(isA<CacheException>()));
    verify(() => references.setBool(kFirstTimerKey, false)).called(1);
    verifyNoMoreInteractions(references);
  });

  group('chechIfFirstTimer', () {
    test('return false if data exist after calling chechIf...', () async {
      when(
        () => references.getBool(
          any(),
        ),
      ).thenReturn(false);

      final result = await lacalSourceImpl.chechIfFirstTimer();
      expect(result, false);

      verify(
        () => references.getBool(kFirstTimerKey),
      ).called(1);
      verifyNoMoreInteractions(references);
    });

    test('return null if no data found on storage.', () async {
      when(
        () => references.getBool(
          any(),
        ),
      ).thenReturn(null);

      final result = await lacalSourceImpl.chechIfFirstTimer();
      expect(result, true);

      verify(
        () => references.getBool(kFirstTimerKey),
      ).called(1);
      verifyNoMoreInteractions(references);
    });
  });

  test('throw an Exception when calls to storage fails.', () async {
    when(
      () => references.getBool(
        any(),
      ),
    ).thenThrow(Exception());

    final result = lacalSourceImpl.chechIfFirstTimer;
    expect(result, throwsA(isA<CacheException>()));

    verify(
      () => references.getBool(kFirstTimerKey),
    ).called(1);
    verifyNoMoreInteractions(references);
  });
}

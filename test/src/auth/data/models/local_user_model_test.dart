import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/auth/data/models/local_user_model.dart';
import 'package:school_app/src/auth/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tMap = jsonDecode(fixture('user.json')) as DataMap;
  const tLocalUserModel = LocalUserModel.empty();

  test('LocalUserModel should be a subclass of user entity', () {
    expect(tLocalUserModel, isA<LocalUser>());
  });

  group('fromMap', () {
    test('should return a valid LocalUserModel from map dat', () {
      const actual = LocalUserModel.fromMap;
      expect(() => actual(tMap), isA<LocalUserModel>());
    });

    test('should throw an error when the map is invalid', () {
      final map = DataMap.from(tMap.remove('uid') as DataMap);
      final actual = LocalUserModel.fromMap(map);
      expect(actual, throwsA(Error));
    });
  });

  test('copyWith should handle any variable sent via LocalUserModel', () {
    final actual = tLocalUserModel.copyWith(uid: 'g4');
    expect(actual, equals('g4'));
  });
}

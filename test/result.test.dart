import 'dart:io';

import 'package:test/test.dart';
import 'package:wedzera/core.dart';

void main() {
  group('Failure Result Tests', () {
    Result<_Child> result;
    setUp(() {
      result = runCatching<_Child>(() {
        throw Exception('unExpected Exception');
      });
    });
    test('isSuccess Test', () {
      expect(result.isSuccess, isFalse);
    });
    test('isFailure Test', () {
      expect(result.isFailure, isTrue);
    });
    test('getOrNull Test', () {
      expect(result.getOrNull(), isNull);
    });
    test('exceptionOrNull Test', () {
      expect(result.exceptionOrNull(), isA<Exception>());
    });
    test('throwOnFailure Test', () {
      expect(() {
        result.throwOnFailure();
      }, throwsException);
    });
    test('getOrThrow Test', () {
      expect(() {
        result.getOrThrow();
      }, throwsException);
    });
    test('getOrElse Test', () {
      expect(result.getOrElse((exception) {
        return _Child();
      }), isA<_Child>());
    });
    test('getOrDefault Test', () {
      expect(result.getOrDefault(_Child()), isA<_Child>());
    });
    test('map Test', () {
      expect(result.map((child) => _Parent()).isFailure, isTrue);
    });
    test('mapCatching Test', () {
      expect(result.mapCatching((child) => _Parent()).isFailure, isTrue);
    });
    test('fold Test', () {
      expect(result.fold((child) => _Parent(), (exception) => _Parent()),
          isA<_Parent>());
    });
  });

  group('Success Result Tests', () {
    Result<_Child> result;
    setUp(() {
      result = runCatching<_Child>(() {
        return _Child();
      });
    });
    test('isSuccess Test', () {
      expect(result.isSuccess, isTrue);
    });
    test('isFailure Test', () {
      expect(result.isFailure, isFalse);
    });
    test('getOrNull Test', () {
      expect(result.getOrNull(), isA<_Child>());
    });
    test('exceptionOrNull Test', () {
      expect(result.exceptionOrNull(), isNull);
    });
    test('throwOnFailure Test', () {
      expect(() {
        result.throwOnFailure();
      }, returnsNormally);
    });
    test('getOrThrow Test', () {
      expect(result.getOrThrow(), isA<_Child>());
    });
    test('getOrElse Test', () {
      expect(result.getOrElse((exception) {
        return _Child();
      }), isA<_Child>());
    });
    test('getOrDefault Test', () {
      expect(result.getOrDefault(_Child()), isA<_Parent>());
    });
    test('map Test', () {
      expect(result.map((child) => _Parent()).isSuccess, isTrue);
    });
    test('mapCatching with No Exception Transform Test', () {
      expect(result.mapCatching((child) => _Parent()).value, isA<_Parent>());
    });
    test('mapCatching with Exception Transform Test', () {
      expect(() {
        result
            .mapCatching((child) => throw const FormatException())
            .throwOnFailure();
      }, throwsFormatException);
    });
    test('fold Test', () {
      expect(result.fold((child) => 'onSuccess', (exception) => 'onFailure'),
          equals('onSuccess'));
    });
  });

  group('runCatchingAsync Test', () {
    test('async read lines of LICENSE Test', () async {
      final result = await runCatchingAsync<List<String>>(() {
        final file = File('LICENSE');
        return file.readAsLines();
      });
      expect(
          result.getOrThrow()[0].trim(),
          equals(
              'Copyright 2020, the Dart project authors. All rights reserved.'));
    });
  });
}

class _Parent {}

class _Child extends _Parent {}

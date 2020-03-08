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
        return _Parent();
      }), isA<_Parent>());
    });
    test('getOrDefault Test', () {
      expect(result.getOrDefault(_Parent()), isA<_Parent>());
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
}

class _Parent {}

class _Child extends _Parent {}

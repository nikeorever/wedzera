import 'package:test/test.dart';
import 'package:wedzera/core.dart';

void main() {
  group('standard test', () {
    test('test run function', () {
      expect(run(() => 'Dart'), equals('Dart'));
    });

    test('test TODO function', () {
      expect(() => TODO('implemented in the future'), throwsUnimplementedError);
    });

    test('test also/let scope function', () {
      expect(
          'Dart'.also(print).let((str) => str.toLowerCase()), equals('dart'));
    });

    test('test takeIf scope function', () {
      expect(6.takeIf(Predicates.inCollection([5, 6])), equals(6));
    });

    test('test takeUnless scope function', () {
      expect(6.takeUnless(Predicates.not(Predicates.inCollection([5, 6]))),
          equals(6));
    });
  });
}

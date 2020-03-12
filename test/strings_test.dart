import 'package:test/test.dart';
import 'package:wedzera/core.dart';

void main() {
  group('Strings Test', () {
    String nullStr;
    String notNullStr = 'Dart';
    String emptyStr = '';
    String blankStr = ' ';
    String notBlankStr = 'Flutter';

    test('orEmpty() with null string Test', () {
      expect(nullStr.orEmpty(), equals(''));
    });

    test('orEmpty() with not null string Test', () {
      expect(notNullStr.orEmpty(), equals('Dart'));
    });

    test('ifEmpty() with null string Test', () {
      expect(nullStr.ifEmpty(() => 'Dart'), equals('Dart'));
    });

    test('ifEmpty() with not null string Test', () {
      expect(notNullStr.ifEmpty(() => 'Flutter'), equals(notNullStr));
    });

    test('ifEmpty() with emtpy string Test', () {
      expect(emptyStr.ifEmpty(() => 'Flutter'), equals('Flutter'));
    });

    test('ifBlank() with blank string Test', () {
      expect(blankStr.ifBlank(() => 'Flutter'), equals('Flutter'));
    });

    test('ifBlank() with not blank string Test', () {
      expect(notBlankStr.ifBlank(() => 'Dart'), equals('Flutter'));
    });

    // toInt() Test Case
    test('toInt() with null str Test', () {
      expect(() {
        nullStr.toInt();
      }, throwsArgumentError);
    });
    test('toInt() with invalid number str Test', () {
      expect(() {
        'InvalidNumber'.toInt();
      }, throwsFormatException);
    });
    test('toInt() with invalid radix Test', () {
      expect(() {
        '1'.toInt(radix: 1);
      }, throwsRangeError);
    });
    test('toInt() with number Test', () {
      expect('1'.toInt(), equals(1));
    });

    // toIntOrNull() Test Case
    test('toIntOrNull() with null str Test', () {
      expect(() {
        nullStr.toIntOrNull();
      }, throwsArgumentError);
    });
    test('toIntOrNull() with invalid number str Test', () {
      expect('InvalidNumber'.toIntOrNull(), isNull);
    });
    test('toIntOrNull() with invalid radix Test', () {
      expect(() {
        '1'.toIntOrNull(radix: 1);
      }, throwsRangeError);
    });
    test('toIntOrNull() with number Test', () {
      expect('1'.toIntOrNull(), equals(1));
    });

    // toDoubleOrNull() Test Case
    test('toDoubleOrNull() with null str Test', () {
      expect(() {
        nullStr.toDoubleOrNull();
      }, throwsArgumentError);
    });
    test('toDoubleOrNull() with invalid number str Test', () {
      expect('InvalidNumber'.toDoubleOrNull(), isNull);
    });
    test('toIntOrNull() with number Test', () {
      expect('1.344'.toDoubleOrNull(), equals(1.344));
    });

    // toDouble() Test Case
    test('toDouble() with null str Test', () {
      expect(() {
        nullStr.toDouble();
      }, throwsArgumentError);
    });
    test('toDouble() with invalid number str Test', () {
      expect(() {
        'InvalidNumber'.toDouble();
      }, throwsFormatException);
    });
    test('toDouble() with number Test', () {
      expect('1.344'.toDouble(), equals(1.344));
    });
  });
}

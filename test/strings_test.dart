import 'package:test/test.dart';
import 'package:wedzera/core.dart';

void main() {
  group('Strings Test', (){
    String nullStr;
    String notNullStr = 'Dart';
    String emptyStr = '';
    String blankStr = ' ';
    String notBlankStr = 'Flutter';

    test('orEmpty() with null string Test', (){
      expect(nullStr.orEmpty(), equals(''));
    });

    test('orEmpty() with not null string Test', (){
      expect(notNullStr.orEmpty(), equals('Dart'));
    });

    test('ifEmpty() with null string Test', () {
      expect(nullStr.ifEmpty(()=>'Dart'), equals('Dart'));
    });

    test('ifEmpty() with not null string Test', () {
      expect(notNullStr.ifEmpty(()=>'Flutter'), equals(notNullStr));
    });

    test('ifEmpty() with emtpy string Test', () {
      expect(emptyStr.ifEmpty(()=>'Flutter'), equals('Flutter'));
    });

    test('ifBlank() with blank string Test', () {
      expect(blankStr.ifBlank(()=>'Flutter'), equals('Flutter'));
    });

    test('ifBlank() with not blank string Test', () {
      expect(notBlankStr.ifBlank(()=>'Dart'), equals('Flutter'));
    });
  });
}
import 'package:test/test.dart';
import 'package:wedzera/core.dart';

void main() {
  final pair = Pair('Language', 'Dart');

  group('Pair Tests', () {
    test('Pair toString Test', () {
      expect(pair.toString(), equals('(${pair.first}, ${pair.second})'));
    });

    test('parsePairAsMutableList Test', () {
      expect(parsePairAsMutableList(pair).length, equals(2));
    });

    test('toMapEntry Test', () {
      final entry = pair.toMapEntry();
      expect(entry.key, equals(pair.first));
      expect(entry.value, equals(pair.second));
    });
  });

  final triple = Triple('A', 'B', 'C');

  group('Triple Tests', () {
    test('Triple toString Test', () {
      expect(triple.toString(),
          equals('(${triple.first}, ${triple.second}, ${triple.third})'));
    });

    test('parseTripleAsMutableList Test', () {
      expect(parseTripleAsMutableList(triple).length, equals(3));
    });

    test('toMapEntry Test', () {
      final entry = pair.toMapEntry();
      expect(entry.key, equals(pair.first));
      expect(entry.value, equals(pair.second));
    });
  });
}

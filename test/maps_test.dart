import 'package:test/test.dart';
import 'package:wedzera/collection.dart';

void main() {
  group('Maps Test', () {
    Map<String, String> valueMap = {'Key': 'Value'};
    test('isNullOrEmpty() Test', () {
      Map<String, String> nullMap;
      Map<String, String> emptyMap = Map();
      expect(nullMap.isNullOrEmpty, isTrue);
      expect(emptyMap.isNullOrEmpty, isTrue);
      expect(valueMap.isNullOrEmpty, isFalse);
    });

    test('getOrElse() with exist key Test', () {
      expect(valueMap.getOrElse('Key', () => 'NewValue'), equals('Value'));
    });

    test('getOrElse() without exist key Test', () {
      expect(valueMap.getOrElse('Key1', () => 'NewValue'), equals('NewValue'));
    });

    test('mapEntryToPair() Test', () {
      expect(
          mapEntryToPair(const MapEntry('Key', 'Value')).first, equals('Key'));
    });

    test('all', () {
      expect({2: 'A', 4: 'B'}.all((entry) => entry.key % 2 == 0), isTrue);
    });

    test('all', () {
      expect({2: 'A', 4: 'B'}.any(), isTrue);
    });
    test('all with emtpy entries', () {
      expect({}.any(), isFalse);
    });
    test('allWhere', () {
      expect({1: 'A', 3: 'B'}.anyWhere((entry) => entry.key % 2 == 0), isFalse);
    });
    test('countWhere', () {
      expect({1: 'A', 2: 'B', 3: 'C'}.countWhere((entry) => entry.key % 2 == 0),
          equals(1));
    });

    test('noneWhere', () {
      expect({1: 'A', 3: 'B', 5: 'C'}.noneWhere((entry) => entry.key % 2 == 0),
          isTrue);
    });
    test('onEach', () {
      expect(
          {1: 'A', 3: 'B', 5: 'C'}
              .onEach(print)
              .noneWhere((entry) => entry.key % 2 == 0),
          isTrue);
    });
  });
}

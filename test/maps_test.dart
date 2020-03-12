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

    test('mapToList() Test', () {
      expect(valueMap.mapToList((k, v) => k + v).length, equals(1));
    });
    test('mapToList() growable Test', () {
      expect(() {
        valueMap.mapToList((k, v) => k + v).add('newValue');
      }, throwsUnsupportedError);
    });

    test('getOrElse() with exist key Test', () {
      expect(valueMap.getOrElse('Key', ()=> 'NewValue'), equals('Value'));
    });

    test('getOrElse() without exist key Test', () {
      expect(valueMap.getOrElse('Key1', ()=> 'NewValue'), equals('NewValue'));
    });

    test('mapEntryToPair() Test', () {
      expect(mapEntryToPair(const MapEntry('Key', 'Value')).first, equals('Key'));
    });
  });
}

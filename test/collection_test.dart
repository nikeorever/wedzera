import 'package:test/test.dart';
import 'package:wedzera/collection.dart';

void main() {
  group('iterables Tests', () {
    test('Null Iterable Test', () {
      Iterable nullIterable;
      expect(nullIterable.isNullOrEmpty, isTrue);
    });

    test('Null List Test', () {
      List<int> nullList;
      expect(nullList.isNullOrEmpty, isTrue);
    });

    test('orEmpty Test', () {
      List<int> nullList;
      expect(nullList.orEmpty(), isNotNull);
    });
  });

  group('maps Tests', () {
    test('Null map Test', () {
      Map<int, int> nullMap;
      expect(nullMap.isNullOrEmpty, isTrue);
    });
  });
}

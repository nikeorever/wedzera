import 'package:test/test.dart';
import 'package:wedzera/collection.dart';
import 'package:wedzera/core.dart';

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

  group('collection Test', () {
    test('mapOf with same key Test', () {
      final map = mapOf([Pair(1, 2), Pair(1, 3), Pair(2, 2)]);
      expect(map[1], equals(3));
    });

    test('mapOf with different key Test', () {
      final map = mapOf([Pair(1, 2), Pair(2, 3), Pair(3, 2)]);
      expect(map.values.fold(0, (acc, ele) => acc + ele), equals(7));
    });

    test('mapOf with modify Test', () {
      final map = mapOf([Pair(1, 2), Pair(2, 3), Pair(3, 2)]);
      expect(() {
        map.clear();
      }, throwsUnsupportedError);
    });

    test('mutableMapOf Test', () {
      final map = mutableMapOf([Pair(1, 2), Pair(2, 3), Pair(3, 2)]);
      expect(() {
        map.clear();
      }, returnsNormally);
    });

    test('list Test', () {
      final li = list(6, (index) => '#$index');
      expect(() {
        li.add('#60');
      }, throwsUnsupportedError);
    });

    test('mutableList Test', () {
      final list = mutableList(6, (index) => '#$index');
      expect(list.length, equals(6));
      expect(list[5], equals('#5'));
    });
  });
}

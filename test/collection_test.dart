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

    test('elementAtOrElse Test', () {
      expect([3, 2, 5, 9].elementAtOrElse(3, (index) => 10), equals(9));
    });

    test('elementAtOrElse else case Test', () {
      expect([3, 2, 5, 9].elementAtOrElse(7, (index) => 10), equals(10));
    });

    test('elementAtOrNull', () {
      expect([3, 2, 5, 9].elementAtOrNull(2), equals(5));
    });

    test('elementAtOrNull else case Test', () {
      expect([3, 2, 5, 9].elementAtOrNull(7), isNull);
    });

    test('firstOrNull null Test', () {
      expect([].firstOrNull(), isNull);
    });
    test('firstOrNull Test', () {
      expect([1, 2].firstOrNull(), equals(1));
    });

    test('lastOrNull', () {
      expect(['A', 'B', 2, 'C', 4, 'D', 8].lastOrNull(), equals(8));
    });
    test('lastOrNullWhere', () {
      expect(
          ['A', 'B', 2, 'C', 4, 'D', 8]
              .lastOrNullWhere(Predicates.isInstance<String>()),
          equals('D'));
    });

    test('singleOrNull', () {
      expect([1].singleOrNull(), equals(1));
    });
    test('singleOrNull null case', () {
      expect([1, 2].singleOrNull(), isNull);
    });
    test('singleOrNullWhere null case', () {
      expect(
          ['A', 'B', 2, 'C', 'D', 8]
              .singleOrNullWhere(Predicates.isInstance<String>()),
          isNull);
    });
    test('singleOrNullWhere case', () {
      expect(
          ['A', 'B', 2, 'C', 'D']
              .singleOrNullWhere(Predicates.isInstance<int>()),
          equals(2));
    });

    test('mapIndexed', () {
      expect([1, 2, 3, 4].mapIndexed((index, ele) => index + ele).sum(),
          equals((0 + 1) + (1 + 2) + (2 + 3) + (3 + 4)));
    });

    test('mapIndexedNotNull', () {
      expect(
          [1, 2, 3, 4].mapIndexedNotNull((index, ele) {
            return index % 2 == 0 ? null : index + ele;
          }).sum(),
          equals((1 + 2) + (3 + 4)));
    });

    test('mapNotNull', () {
      expect(
          [1, 2, 3, 4].mapNotNull((ele) {
            return ele % 2 == 0 ? null : ele * ele;
          }).sum(),
          equals((1 * 1) + (3 * 3)));
    });

    test('withIndex', () {
      expect(['A', 'B', 'C'].withIndex().first.index, equals(0));
    });

    test('none', () {
      expect([].none(), isTrue);
    });

    test('whereIndexed Test', () {
      expect(
          ['A', 'B', 'C3', 'D', 'CE', 'F', 'G']
              .whereIndexed((index, ele) => index % 2 == 0)
              .where((t) => t.startsWith('C'))
              .join(),
          equals('C3CE'));
    });

    test('whereTypeToMutableList Test', () {
      expect(
          ['A', 'B', 'C3', 'D', 10, 'F', 10]
              .whereTypeToMutableList<int>()
              .sum(),
          equals(20));
    });

    test('whereToMutableList Test', () {
      expect(
          ['A', 'B', 'C3', 'D', 10, 'F', 10]
              .whereToMutableList(Predicates.isInstance<int>())
              .sumBy((t) => t),
          equals(20));
    });

    test('whereNotNullToMutableList Test', () {
      expect([10, null, 10, null].whereNotNullToMutableList().average(),
          equals(10));
    });

    test('whereNot Test', () {
      expect([10, null, 10, null].whereNot(Predicates.isNull()).sumBy((t) => t),
          equals(20));
    });

    test('whereNotNull', () {
      expect(['A', null, 'C', null, 'D', 'E'].whereNotNull().join(),
          equals('ACDE'));
    });

    test('whereNot', () {
      expect(
          ['A', null, 'C', null, 'D', 'E', 5, 10]
              .whereNot(Predicates.isInstance<String>())
              .count(),
          equals(4));
    });

    test('count', () {
      expect(
          ['A', null, 'C', null, 'D', 'E'].whereNotNull().count(), equals(4));
    });

    test('countWhere', () {
      expect(
          ['A', null, 'C', null, 'D', 'E', 5, 10]
              .whereNotNull()
              .countWhere(Predicates.isInstance<int>()),
          equals(2));
    });

    test('scan', () {
      // 10, 11, 13, 16, 20, 25
      expect([1, 2, 3, 4, 5].scan<int>(10, (acc, ele) => acc + ele).sum(),
          equals(95));
    });

    test('scanReduce', () {
      // 1, 3, 6, 10, 15
      expect([1, 2, 3, 4, 5].scanReduce((acc, ele) => acc + ele).sum(),
          equals(35));
    });

    test('min value in double iterable', () {
      expect([9.0, 3.0, 2.6].min(), equals(2.6));
    });

    test('max value in double iterable', () {
      expect([9.0, 3.0, 2.6].max(), equals(9.0));
    });

    test('partition', () {
      expect(
          ['A', 2, 'C', 4]
              .partition(Predicates.isInstance<String>())
              .first
              .join(),
          equals('AC'));
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

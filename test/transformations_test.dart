import 'package:test/test.dart';
import 'package:wedzera/collection.dart';
import 'package:wedzera/core.dart';

void main() {
  group('Transformations Test', () {
    test('toStringTransformation', () {
      expect(
          [1, 4]
              .map(Transformations.toStringTransformation())
              .map((t) => t.toInt())
              .sumBy((t) => t),
          equals(5));
    });

    test('constant', () {
      expect(
          [1, 4]
              .map(Transformations.constant(5))
              .map((t) => t.toInt())
              .sumBy((t) => t),
          equals(10));
    });
    test('forMapWithDefault', () {
      expect(
          [1, 4]
              .map(Transformations.forMapWithDefault({1: 5}, 5))
              .map((t) => t.toInt())
              .sumBy((t) => t),
          equals(10));
    });
    test('forMap', () {
      expect(() {
        [1, 4]
            .map(Transformations.forMap({1: 5}))
            .map((t) => t.toInt())
            .sumBy((t) => t);
      }, throwsArgumentError);
    });
    test('identity', () {
      expect(
          [1, 4]
              .map(Transformations.identity())
              .map((t) => t.toInt())
              .sumBy((t) => t),
          equals(5));
    });
    test('forPredicate', () {
      expect(
          [2, 4]
              .map(Transformations.forPredicate(Predicates.isEven()))
              .all((t) => t),
          isTrue);
    });
    test('forPredicate', () {
      expect(
          [2, 4]
              .map(Transformations.compose(
                  Transformations.identity(), (t) => t * t))
              .sumBy((t) => t),
          equals(20));
    });
  });
}

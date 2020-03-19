import 'package:test/test.dart';
import 'package:wedzera/core.dart';

void main() {
  group('Predicates Test', () {
    test('inCollection', () {
      expect(
          [1, 2, 3, 4, 5]
              .where(Predicates.inCollection([2, 4]))
              .fold(0, (acc, ele) => acc + ele),
          equals(6));
    });
    test('in null Collection', () {
      expect(() {
        [1, 2, 3, 4, 5]
            .where(Predicates.inCollection(null))
            .fold(0, (acc, ele) => acc + ele);
      }, throwsArgumentError);
    });

    test('equalTo', () {
      expect([1, 2, 3, 4, 5].indexWhere(Predicates.equalTo(5)), equals(4));
    });
    test('equalTo null', () {
      expect([1, 2, 3, 4, 5].indexWhere(Predicates.equalTo(null)), equals(-1));
    });

    test('and', () {
      expect(
          [1, 2, 3, 4]
              .where(Predicates.and([
                Predicates.inCollection([1, 3, 4]),
                Predicates.isEven()
              ]))
              .first,
          equals(4));
    });

    test('or', () {
      expect(
          [1, 2, 3, 4]
              .where(Predicates.or([
                Predicates.inCollection([1, 3, 4]),
                Predicates.isEven()
              ]))
              .length,
          equals(4));
    });

    test('instanceOf double', () {
      expect([1, 2, 3, 4].where(Predicates.isInstance<double>()).length,
          equals(0));
    });
    test('instanceOf int', () {
      expect([1, 2, 3, 4, null].where(Predicates.isInstance<int>()).length,
          equals(4));
    });

    test('compose', () {
      expect(
          [1, 2, 3, 4]
              .where(Predicates.compose(
                  Predicates.equalTo('Dart'),
                  Transformations.forMap(
                      {1: 'Flutter', 2: 'Dart', 3: 'Android', 4: 'Kotlin'})))
              .first,
          equals(2));
    });
  });
}

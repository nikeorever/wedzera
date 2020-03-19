part of wedzera.core;

typedef Predicate<T> = bool Function(T);

class Predicates {
  Predicates._();
  static Predicate<T> alwaysTrue<T>() {
    return (t) => true;
  }

  static Predicate<T> alwaysFalse<T>() {
    return (t) => false;
  }

  /// Returns a predicate that evaluates to [true] if the object reference being tested is null.
  static Predicate<T> isNull<T>() {
    return (t) => t == null;
  }

  /// Returns a predicate that evaluates to [true] if the object reference being tested is not null.
  static Predicate<T> notNull<T>() {
    return (t) => t != null;
  }

  /// Returns a predicate that evaluates to [true] if the given [predicate] evaluates to [false].
  static Predicate<T> not<T>(Predicate<T> predicate) {
    return (t) => !predicate(t);
  }

  /// Returns a predicate that evaluates to [true] if each of its [components] evaluates to [true].
  /// The [components] are evaluated in order, and evaluation will be "short-circuited" as soon as a false predicate is found.
  /// It defensively copies the iterable passed in, so future changes to it won't alter the behavior of the predicate.
  /// If [components] is emtpy, the returnd predicate will always evaluate to true.
  static Predicate<T> and<T>(Iterable<Predicate<T>> components) {
    components = _defensiveCopy(components);
    return (t) {
      for (final test in components) {
        if (!test(t)) return false;
      }
      return true;
    };
  }

  /// Returns a predicate that evaluates ot [true] if any one of its [components] evaluates to [true].
  /// The components are evaluated in order, and evaluation will be "short-circuited" as soon as a [true] predicate is found.
  /// It defensively copies the iterable passed in, so future change to it won't alter the behavior of this predicate. If [components] is emtpy,
  /// the returned predicate will always evaluate to [false].
  static Predicate<T> or<T>(Iterable<Predicate<T>> components) {
    components = _defensiveCopy(components);
    return (t) {
      for (final test in components) {
        if (test(t)) return true;
      }
      return false;
    };
  }

  /// Returns a predicate that evaluates to [true] if the object being tested equals[Object.==] the given target or both are null.
  static Predicate<T> equalTo<T>(T target) {
    return target == null ? Predicates.isNull<T>() : (t) => t == target;
  }

  /// Returns a predicate that evaluates to [true] if the object being tested is an instance of [T].
  /// If the object being tested is [null] the predicate evaluates to [false]
  static Predicate<Object> isInstance<T>() => (t) => t is T;

  /// Returns a predicate that evaluates to [true] if the object reference being tested is a
  /// member of the given [target]. It does not defensively copy the collection passed in, so
  /// future chagnes to it will after the behavior of the predicate.
  ///
  /// Throws an [ArgumentError] if the given [target] is `null`.
  static Predicate<T> inCollection<T>(Iterable<T> target) {
    checkNotNull(target);
    return (t) => runCatching(() => target.contains(t)).getOrDefault(false);
  }

  /// Returns the composition of a [transformation] and a [predicate].
  static Predicate<A> compose<A, B>(
      Predicate<B> predicate, Transformation<A, B> transformation) {
    checkNotNull(predicate);
    checkNotNull(transformation);
    return (a) => predicate(transformation(a));
  }

  static List<T> _defensiveCopy<T>(Iterable<T> iterable) {
    return List.from(iterable.requireNoNulls(), growable: true);
  }

  /// Returns a predicate that evaluates to [true] if the int value being tested is odd.
  static Predicate<int> isOdd() => (t) => t % 2 != 0;

  /// Returns a predicate that evaluates to [true] if the int value being tested is even.
  static Predicate<int> isEven() => (t) => t % 2 == 0;
}

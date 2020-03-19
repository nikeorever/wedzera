part of wedzera.core;

typedef Transformation<T, R> = R Function(T);

class Transformations {
  Transformations._();

  /// The [Transformation] simply invokes [toString] on its argument and returns the result.
  /// It throws an [ArgumentError] on null input.
  static Transformation<Object, String> toStringTransformation() =>
      (t) => checkNotNull(t).toString();

  /// Returns a [Transformation] that always returns its input argument.
  static Transformation<T, T> identity<T>() => (t) => t;

  /// Returns a [Transformation] which performs a map lookup. The returned function throws an [ArgumentError]
  /// if given a key that does not exist in the map. See also [forMapWithDefault], which returns a default value in this case.
  static Transformation<K, V> forMap<K, V>(Map<K, V> map) {
    checkNotNull(map);
    return (key) {
      final result = map[key];
      checkArgument(result != null || map.containsKey(key),
          message: "Key '$key' not present in map");
      return result;
    };
  }

  /// Returns a [Transformation] which performs a map lookup with a default value. The [Transformation] created by
  /// this method returns [defaultValue] for all inputs that do not belong to the map's keyset.
  /// See also [forMap], which throws an exception in this case.
  static Transformation<K, V> forMapWithDefault<K, V>(
      Map<K, V> map, V defaultValue) {
    checkNotNull(map);
    return (key) {
      final result = map[key];
      return (result != null || map.containsKey(key)) ? result : defaultValue;
    };
  }

  /// Creates a [Transformation] that returns the same [bool] output as the given [predicate] for all inputs.
  static Transformation<T, bool> forPredicate<T>(Predicate<T> predicate) {
    checkNotNull(predicate);
    return (t) => predicate(t);
  }

  /// Returns a [Transformation] that ignores its input and always return [value].
  static Transformation<Object, E> constant<E>(E value) {
    return (t) => value;
  }

  /// Returns the composition of two transformations.For f: A->B and g: B -> C, composition is defined as the transformation h
  /// such that h(a) = g(f(a)) for each a
  static Transformation<A, C> compose<A, B, C>(
          Transformation<B, C> g, Transformation<A, B> f) =>
      (t) => g(f(t));
}

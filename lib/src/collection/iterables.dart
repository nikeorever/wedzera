part of wedzera.collection;

/// Extension class for [Iterable]
extension Iterables<E> on Iterable<E> {
  /// Returns `true` if this nullable collection is either null or empty.
  bool get isNullOrEmpty => this == null || isEmpty;

  /// Returns this Collection if it's not `null` and the empty iterable otherwise.
  Iterable<E> orEmpty() => this ?? const Iterable.empty();

  /// Returns a new lazy [Iterable] with all elements that satisfy the
  /// predicate [test].
  /// [test] function that takes the index of an element and the element itself
  /// and returns the result of predicate evaluation on the element.
  Iterable<E> whereIndexed(bool Function(int index, E) test) {
    return WhereIndexedIterable<E>(this, test);
  }

  /// Returns a new lazy [Iterable] containing all elements that are not `null`.
  Iterable<E> whereNotNull() => where(Predicates.notNull());

  /// Returns the number of elements in this [Iterable].
  int count() {
    var count = 0;
    for (final _ in this) {
      ++count;
    }
    return count;
  }

  /// Returns the number of elements matching the given [predicate].
  int countWhere(bool Function(E) predicate) {
    var count = 0;
    for (final element in this) {
      if (predicate(element)) {
        ++count;
      }
    }
    return count;
  }

  /// Returns `true` if all elements match the given [predicate].
  bool all(bool Function(E) predicate) {
    if (isNullOrEmpty) return true;
    for (final element in this) {
      if (!predicate(element)) return false;
    }
    return true;
  }

  /// Returns the sum of all values produced by [selector] function applied to each element in the collection.
  int sumBy(int Function(E) selector) {
    var sum = 0;
    for (final ele in this) {
      sum += selector(ele);
    }
    return sum;
  }

  /// Returns the sum of all values produced by [selector] function applied to each element in the collection.
  double sumByDouble(double Function(E) selector) {
    var sum = 0.0;
    for (final ele in this) {
      sum += selector(ele);
    }
    return sum;
  }

  /// Returns an original collection containing all the non-`null` elements,
  /// throwing an [ArgumentError] if there are any `null` elements.
  Iterable<E> requireNoNulls() {
    for (final ele in this) {
      checkNotNull(ele, message: 'null element found in $this.');
    }
    return this;
  }

  /// Returns `true` if no elements match the given [predicate].
  bool none(bool Function(E) predicate) {
    if (isNullOrEmpty) return true;
    for (final ele in this) {
      if (predicate(ele)) return false;
    }
    return true;
  }

  /// Returns an unmodifiable [Map] containing the elements from the given collection indexed by the key
  /// returned from [keySelector] function applied to each element.
  ///
  /// If any two elements would have the same key returned by [keySelector] the last one gets added to the map.
  ///
  /// The returned map preserves the entry iteration order of the original collection.
  Map<K, E> associateBy<K>(K Function(E) keySelector) {
    // LinkedHashMap
    final destination = Map.identity();
    for (final ele in this) {
      destination[keySelector(ele)] = ele;
    }
    return Map.unmodifiable(destination);
  }

  /// Returns an unmodifiable [Map] containing the values provided by [valueTransform] and indexed by [keySelector] functions applied to elements of the given collection.
  ///
  /// If any two elements would have the same key returned by [keySelector] the last one gets added to the map.
  ///
  /// The returned map preserves the entry iteration order of the original collection.
  // https://github.com/dart-lang/sdk/issues/26488
  Map<K, V> associateBy2<K, V>(
      K Function(E) keySelector, V Function(E) valueTransform) {
    // LinkedHashMap
    final destination = Map.identity();
    for (final ele in this) {
      destination[keySelector(ele)] = valueTransform(ele);
    }
    return Map.unmodifiable(destination);
  }

  /// Returns an unmodifiable [Map] containing key-value pairs provided by [transform] function
  /// applied to elements of the given collection.
  ///
  /// If any of two pairs would have the same key the last one gets added to the map.
  ///
  /// The returned map preserves the entry iteration order of the original collection.
  Map<K, V> associate<K, V>(Pair<K, V> Function(E) transform) {
    return mapOf(map(transform));
  }

  /// Returns an unmodifiable [Map] where keys are elements from the given collection and values are
  /// produced by the [valueSelector] function applied to each element.
  ///
  /// If any two elements are equal, the last one gets added to the map.
  ///
  /// The returned map preserves the entry iteration order of the original collection.
  Map<E, V> associateWith<V>(V Function(E) valueSelector) {
    // LinkedHashMap
    final destination = Map.identity();
    for (final ele in this) {
      destination[ele] = valueSelector(ele);
    }
    return Map.unmodifiable(destination);
  }
}

part of wedzera.collection;

/// Extension class for [Iterable]
extension GeneralIterable<E> on Iterable<E> {
  /// Returns `true` if this nullable collection is either null or empty.
  bool get isNullOrEmpty => this == null || isEmpty;

  /// Returns this Collection if it's not `null` and the empty iterable otherwise.
  Iterable<E> orEmpty() => this ?? const Iterable.empty();

  /// Returns an element at the given [index] or the result of calling the [defaultValue] function
  /// if the [index] is out of bounds of this [Iterable].
  E elementAtOrElse(int index, E Function(int index) defaultValue) {
    if (index < 0) return defaultValue(index);
    final iterator = this.iterator;
    var count = 0;
    while (iterator.moveNext()) {
      final element = iterator.current;
      if (index == count++) return element;
    }
    return defaultValue(index);
  }

  /// Returns an element at the given [index] or `null` if the [index] is out of bounds of this [Iterable].
  E elementAtOrNull(int index) {
    if (index < 0) return null;
    final iterator = this.iterator;
    var count = 0;
    while (iterator.moveNext()) {
      final element = iterator.current;
      if (index == count++) return element;
    }
    return null;
  }

  /// Returns the first element, or `null` if the [Iterable] is empty
  E firstOrNull() {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    return iterator.current;
  }

  /// Returns the first element matching the given [predicate] , or `null` if element was not found
  E firstOrNullWhere(bool Function(E) predicate) {
    for (final element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }

  /// Returns the last element, or `null` if the [Iterable] is empty.
  E lastOrNull() {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    var last = iterator.current;
    while (iterator.moveNext()) {
      last = iterator.current;
    }
    return last;
  }

  /// Returns the last element matching the given [predicate], or `null` if no such element was found.
  E lastOrNullWhere(bool Function(E) predicate) {
    E last;
    for (final element in this) {
      if (predicate(element)) {
        last = element;
      }
    }
    return last;
  }

  /// Returns single element, or `null` if the [Iterable] is empty or has more than one element.
  E singleOrNull() {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    final single = iterator.current;
    if (iterator.moveNext()) return null;
    return single;
  }

  /// Returns the single element matching the given [predicate],
  /// or `null` if element was not found or more than one element was found.
  E singleOrNullWhere(bool Function(E) predicate) {
    E single;
    bool found = false;
    for (final element in this) {
      if (predicate(element)) {
        if (found) return null;
        single = element;
        found = true;
      }
    }
    if (!found) return null;
    return single;
  }

  /// Returns a [Iterable] containing the results of applying the given [transform] function
  /// to each element and its index in the original [Iterable].
  /// [transform] function that takes the index of an element and the element itself
  /// and returns the result of the transform applied to the element.
  Iterable<R> mapIndexed<R>(R Function(int index, E) transform) {
    return withIndex().map<R>(
        (indexedValue) => transform(indexedValue.index, indexedValue.value));
  }

  /// Returns a [Iterable] containing only the non-null results of applying the given [transform] function
  /// to each element and its index in the origin [Iterable].
  /// [transform] function that takes the index of element and the element itself and returns
  /// the result of the transform applied to the element.
  Iterable<R> mapIndexedNotNull<R>(R Function(int index, E) transform) {
    return mapIndexed<R>(transform).whereNotNull();
  }

  /// Returns a [Iterable] containing only the non-null results of applying the given [transfrom] function
  /// to each element in the original [Iterable].
  Iterable<R> mapNotNull<R>(R Function(E) transform) {
    return map<R>(transform).whereNotNull();
  }

  /// Returns a [Iterable] that wraps each element of the original [Iterable]
  /// into an [IndexedValue] containing the index of that element and the element itself.
  Iterable<IndexedValue<E>> withIndex() => enumerate<E>(this);

  /// Returns a new lazy [Iterable] with all elements that satisfy the
  /// predicate [test].
  /// [test] function that takes the index of an element and the element itself
  /// and returns the result of predicate evaluation on the element.
  Iterable<E> whereIndexed(bool Function(int index, E) test) {
    return WhereIndexedIterable<E>(this, test);
  }

  /// Returns a new lazy [Iterable] containing all elements that are not `null`.
  Iterable<E> whereNotNull() => where(Predicates.notNull());

  /// Returns a new lazy [Iterable] containing all elements not matching the given [predicate]
  Iterable<E> whereNot(bool Function(E) predicate) =>
      where(Predicates.not(predicate));

  /// Performs the given [action] on each element, providing sequential index with the element.
  /// [action] function that takes the index of an element and the element itself
  /// and performs the desired action on the element.
  void forEachIndexed(void Function(int index, E) action) {
    var index = 0;
    for (final element in this) {
      action(index++, element);
    }
  }

  /// Accumulates value starting with [initial] value and applying [operation] from left to right
  /// to current accumulator value and each element with its index in the original [Iterable].
  /// [operation] function that takes the index of an element, current accumulator value
  /// and the element itself, and calculates the next accumulator value.
  R foldIndexed<R>(R inital, R Function(int index, R acc, E) operation) {
    var index = 0;
    var accumulator = inital;
    for (final element in this) {
      accumulator = operation(index++, accumulator, element);
    }
    return accumulator;
  }

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

  /// Returns `true` if the [Iterable] has no elements.
  bool none() => !iterator.moveNext();

  /// Returns `true` if no elements match the given [predicate].
  bool noneWhere(bool Function(E) predicate) {
    if (isNullOrEmpty) return true;
    for (final ele in this) {
      if (predicate(ele)) return false;
    }
    return true;
  }

  /// Returns a [Iterable] which performs the given [action] on each
  /// element of the original [Iterable] as they pass through it.
  Iterable<E> onEach(void Function(E) action) {
    return map((e) {
      action(e);
      return e;
    });
  }

  /// Returns a [Iterable] containing only distinct elements from the given [Iterable].
  ///
  /// The elements in the resulting [Iterable] are in the same order as they were in the source [Iterable].
  Iterable<E> distinct() => distinctBy<E>(Transformations.identity());

  /// Returns a [Iterable] containing only elements from the given [Iterable]
  /// having distinct keys returned by the given [selector] function.
  ///
  /// The elements in the resulting [Iterable] are in the same order as they were in the source [Iterable].
  /// @sample samples.collections.Collections.Transformations.distinctAndDistinctBy
  Iterable<E> distinctBy<K>(K Function(E) selector) {
    return DistinctIterable<E, K>(this, selector);
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

  /// Returns a [Iterable] containing successive accumulation values generated by applying [operation] from left to right
  /// to each element and current accumulator value that starts with [initial] value.
  ///
  /// Note that `acc` value passed to [operation] function should not be mutated;
  /// otherwise it would affect the previous value in resulting sequence.
  /// The [initial] value should also be immutable (or should not be mutated)
  /// as it may be passed to [operation] function later because of sequence's lazy nature.
  ///
  /// [operation] function that takes current accumulator value and an element, and calculates the next accumulator value.
  Iterable<R> scan<R>(R initial, R Function(R acc, E) operation) sync* {
    yield initial;
    var accumulator = initial;
    for (final element in this) {
      accumulator = operation(accumulator, element);
      yield accumulator;
    }
  }

  /// Returns a [Iterable] containing successive accumulation values generated by applying [operation] from left to right
  /// to each element, its index in the original sequence and current accumulator value that starts with [initial] value.
  ///
  /// Note that `acc` value passed to [operation] function should not be mutated;
  /// otherwise it would affect the previous value in resulting sequence.
  /// The [initial] value should also be immutable (or should not be mutated)
  /// as it may be passed to [operation] function later because of sequence's lazy nature.
  ///
  /// [operation] function that takes the index of an element, current accumulator value
  /// and the element itself, and calculates the next accumulator value.
  Iterable<R> scanIndexed<R>(
      R initial, R Function(int index, R acc, E) operation) sync* {
    yield initial;
    var index = 0;
    var accumulator = initial;
    for (final element in this) {
      accumulator = operation(index++, accumulator, element);
      yield accumulator;
    }
  }

  /// Returns a [Iterable] containing successive accumulation values generated by applying [operation] from left to right
  /// to each element and current accumulator value that starts with the first element of this sequence.
  ///
  /// Note that `acc` value passed to [operation] function should not be mutated;
  /// otherwise it would affect the previous value in resulting sequence.
  ///
  /// [operation] function that takes current accumulator value and the element, and calculates the next accumulator value.
  Iterable<E> scanReduce(E Function(E acc, E) operation) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      var accumulator = iterator.current;
      yield accumulator;
      while (iterator.moveNext()) {
        accumulator = operation(accumulator, iterator.current);
        yield accumulator;
      }
    }
  }

  /// Returns a [Iterable] containing successive accumulation values generated by applying [operation] from left to right
  /// to each element, its index in the original sequence and current accumulator value that starts with the first element of this sequence.
  ///
  /// Note that `acc` value passed to [operation] function should not be mutated;
  /// otherwise it would affect the previous value in resulting sequence.
  ///
  /// [operation] function that takes the index of an element, current accumulator value
  /// and the element itself, and calculates the next accumulator value.
  Iterable<E> scanReduceIndexed(
      E Function(int index, E acc, E) operation) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      var accumulator = iterator.current;
      yield accumulator;
      var index = 1;
      while (iterator.moveNext()) {
        accumulator = operation(index++, accumulator, iterator.current);
        yield accumulator;
      }
    }
  }

  /// Splits the original [Iterable] into pair of lists,
  /// where *first* list contains elements for which [predicate] yielded `true`,
  /// while *second* list contains elements for which [predicate] yielded `false`.
  Pair<List<E>, List<E>> partition(bool Function(E) predicate) {
    final first = <E>[];
    final second = <E>[];
    for (final element in this) {
      if (predicate(element)) {
        first.add(element);
      } else {
        second.add(element);
      }
    }
    return Pair(first, second);
  }
}

extension IntIterable on Iterable<int> {
  /// Returns the sum of all elements in the [Iterable].
  int sum() {
    var sum = 0;
    for (final ele in this) {
      sum += ele;
    }
    return sum;
  }

  /// Returns an average value of elements in the [Iterable].
  double average() {
    double sum = 0.0;
    int count = 0;
    for (final ele in this) {
      sum += ele;
      ++count;
    }
    return count == 0 ? double.nan : sum / count;
  }
}

extension DoubleIterable on Iterable<double> {
  /// Returns the sum of all elements in the [Iterable].
  double sum() {
    var sum = 0.0;
    for (final ele in this) {
      sum += ele;
    }
    return sum;
  }

  /// Returns an average value of elements in the [Iterable].
  double average() {
    double sum = 0.0;
    int count = 0;
    for (final ele in this) {
      sum += ele;
      ++count;
    }
    return count == 0 ? double.nan : sum / count;
  }

  /// Returns the largest element or `null` if there are no elements.
  ///
  /// If any of elements is `NaN` returns `NaN`.
  double max() {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    var max = iterator.current;
    if (max.isNaN) return max;
    while (iterator.moveNext()) {
      final e = iterator.current;
      if (e.isNaN) return e;
      if (max < e) max = e;
    }
    return max;
  }

  /// Returns the smallest element or `null` if there are no elements.
  ///
  /// If any of elements is `NaN` returns `NaN`.
  double min() {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    var min = iterator.current;
    if (min.isNaN) return min;
    while (iterator.moveNext()) {
      final e = iterator.current;
      if (e.isNaN) return e;
      if (min > e) min = e;
    }
    return min;
  }
}

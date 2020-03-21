part of wedzera.collection;

/// Represents a source of elements with a [keyOf] function, which can be applied to each element to get its key.
///
/// A [Grouping] structure serves as an intermediate step in group-and-fold operations:
/// they group elements by their keys and then fold each group with some aggregating operation.
///
/// It is created by attaching `K Function(T) keySelector` function to a source of elements.
/// To get an instance of [Grouping] use one of `groupingBy` extension functions:
/// - [Iterable.groupingBy]
abstract class Grouping<T, K> {
  factory Grouping.fromIterable(
      Iterable<T> iterable, K Function(T) keySelector) {
    return _IterableGrouping(iterable, keySelector);
  }

  /// Gets an [Iterator] over the elements of the source of this grouping
  Iterator<T> get sourceIterator;

  /// Extracts the key of an [element].
  K keyOf(T element);
}

class _IterableGrouping<T, K> implements Grouping<T, K> {
  _IterableGrouping(this._iterable, this._f);

  final Iterable<T> _iterable;
  final K Function(T) _f;

  @override
  K keyOf(T element) => _f(element);

  @override
  Iterator<T> get sourceIterator => _iterable.iterator;
}

extension GroupingExtension<T, K> on Grouping<T, K> {
  /// Groups elements from the [Grouping] source by key and applies [operation] to the elements of each group sequentially,
  /// passing the previously accumulated value and the current element as arguments, and stores the results in a new map.
  ///
  /// The key for each element is provided by the [Grouping.keyOf] function.
  ///
  /// [operation] function is invoked on each element with the following parameters:
  ///  - `key`: the key of the group this element belongs to;
  ///  - `accumulator`: the current value of the accumulator of the group, can be `null` if it's the first `element` encountered in the group;
  ///  - `element`: the element from the source being aggregated;
  ///  - `first`: indicates whether it's the first `element` encountered in the group.
  ///
  /// return a [Map] associating the key of each group with the result of aggregation of the group elements.
  Map<K, R> aggregate<R>(
      R Function(K key, R accumulator, T element, bool first) operation) {
    return aggregateTo<R, Map<K, R>>(<K, R>{}, operation);
  }

  /// Groups elements from the [Grouping] source by key and applies [operation] to the elements of each group sequentially,
  /// passing the previously accumulated value and the current element as arguments,
  /// and stores the results in the given [destination] map.
  ///
  /// The key for each element is provided by the [Grouping.keyOf] function.
  ///
  /// [operation] a function that is invoked on each element with the following parameters:
  ///  - `key`: the key of the group this element belongs to;
  ///  - `accumulator`: the current value of the accumulator of the group, can be `null` if it's the first `element` encountered in the group;
  ///  - `element`: the element from the source being aggregated;
  ///  - `first`: indicates whether it's the first `element` encountered in the group.
  ///
  /// If the [destination] map already has a value corresponding to some key,
  /// then the elements being aggregated for that key are never considered as `first`.
  ///
  /// return the [destination] map associating the key of each group with the result of aggregation of the group elements.
  M aggregateTo<R, M extends Map<K, R>>(M destination,
      R Function(K key, R accumulator, T element, bool first) operation) {
    final iterator = sourceIterator;
    while (iterator.moveNext()) {
      final e = iterator.current;
      final key = keyOf(e);
      final accumulator = destination[key];
      destination[key] = operation(key, accumulator, e,
          accumulator == null && !destination.containsKey(key));
    }
    return destination;
  }

  /// Groups elements from the [Grouping] source by key and applies [operation] to the elements of each group sequentially,
  /// passing the previously accumulated value and the current element as arguments, and stores the results in a new map.
  /// An initial value of accumulator is provided by [initialValueSelector] function.
  ///
  /// [initialValueSelector] a function that provides an initial value of accumulator for each group.
  ///  It's invoked with parameters:
  ///  - `key`: the key of the group;
  ///  - `element`: the first element being encountered in that group.
  ///
  /// [operation] a function that is invoked on each element with the following parameters:
  ///  - `key`: the key of the group this element belongs to;
  ///  - `accumulator`: the current value of the accumulator of the group;
  ///  - `element`: the element from the source being accumulated.
  ///
  /// return a [Map] associating the key of each group with the result of accumulating the group elements.
  Map<K, R> fold<R>(R Function(K key, T element) initialValueSelector,
          R Function(K key, R accumulator, T element) operation) =>
      aggregate<R>((key, acc, e, first) =>
          operation(key, first ? initialValueSelector(key, e) : acc, e));

  /// Groups elements from the [Grouping] source by key and applies [operation] to the elements of each group sequentially,
  /// passing the previously accumulated value and the current element as arguments,
  /// and stores the results in the given [destination] map.
  /// An initial value of accumulator is provided by [initialValueSelector] function.
  ///
  /// [initialValueSelector] a function that provides an initial value of accumulator for each group.
  ///  It's invoked with parameters:
  ///  - `key`: the key of the group;
  ///  - `element`: the first element being encountered in that group.
  ///
  /// If the [destination] map already has a value corresponding to some key, that value is used as an initial value of
  /// the accumulator for that group and the [initialValueSelector] function is not called for that group.
  ///
  /// [operation] a function that is invoked on each element with the following parameters:
  ///  - `key`: the key of the group this element belongs to;
  ///  - `accumulator`: the current value of the accumulator of the group;
  ///  - `element`: the element from the source being accumulated.
  ///
  /// return the [destination] map associating the key of each group with the result of accumulating the group elements.
  M foldTo<R, M extends Map<K, R>>(
          M destination,
          R Function(K key, T element) initialValueSelector,
          R Function(K key, R accumulator, T element) operation) =>
      aggregateTo<R, M>(
          destination,
          (key, acc, e, first) =>
              operation(key, first ? initialValueSelector(key, e) : acc, e));

  /// Groups elements from the [Grouping] source by key and applies the reducing [operation] to the elements of each group
  /// sequentially starting from the second element of the group,
  /// passing the previously accumulated value and the current element as arguments,
  /// and stores the results in a new map.
  /// An initial value of accumulator is the first element of the group.
  ///
  /// [operation] a function that is invoked on each subsequent element of the group with the following parameters:
  ///  - `key`: the key of the group this element belongs to;
  ///  - `accumulator`: the current value of the accumulator of the group;
  ///  - `element`: the element from the source being accumulated.
  ///
  /// return a [Map] associating the key of each group with the result of accumulating the group elements.
  Map<K, T> reduce(T Function(K key, T accumulator, T element) operation) =>
      aggregate<T>((key, acc, e, first) => first ? e : operation(key, acc, e));

  /// Groups elements from the [Grouping] source by key and applies the reducing [operation] to the elements of each group
  /// sequentially starting from the second element of the group,
  /// passing the previously accumulated value and the current element as arguments,
  /// and stores the results in the given [destination] map.
  /// An initial value of accumulator is the first element of the group.

  /// If the [destination] map already has a value corresponding to the key of some group,
  /// that value is used as an initial value of the accumulator for that group and the first element of that group is also
  /// subjected to the [operation].

  /// [operation] a function that is invoked on each subsequent element of the group with the following parameters:
  /// - `accumulator`: the current value of the accumulator of the group;
  /// - `element`: the element from the source being folded;

  /// return the [destination] map associating the key of each group with the result of accumulating the group elements.
  M reduceTo<M extends Map<K, T>>(M destination,
          T Function(K key, T accumulator, T element) operation) =>
      aggregateTo(destination,
          (key, acc, e, first) => first ? e : operation(key, acc, e));

  /// Groups elements from the [Grouping] source by key and counts elements in each group to the given [destination] map.
  ///
  /// If the [destination] map already has a value corresponding to the key of some group,
  /// that value is used as an initial value of the counter for that group.
  ///
  /// return the [destination] map associating the key of each group with the count of elements in the group.
  M eachCountTo<M extends Map<K, int>>(M destination) =>
      foldTo<int, M>(destination, (key, ele) => 0, (key, acc, ele) => acc + 1);
}

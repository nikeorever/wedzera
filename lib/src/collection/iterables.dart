part of wedzera.collection;

/// Extension library for [Iterable]
extension Iterables<T> on Iterable<T> {
  /// Returns `true` if this nullable collection is either null or empty.
  bool get isNullOrEmpty => this == null || isEmpty;

  /// Returns this Collection if it's not `null` and the empty iterable otherwise.
  Iterable<T> orEmpty() => this ?? const Iterable.empty();
}

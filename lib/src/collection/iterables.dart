part of wedzera.collection;

/// Extension library for [Iterable]
extension Iterables<E> on Iterable<E> {
  /// Returns `true` if this nullable collection is either null or empty.
  bool get isNullOrEmpty => this == null || isEmpty;

  /// Returns this Collection if it's not `null` and the empty iterable otherwise.
  Iterable<E> orEmpty() => this ?? const Iterable.empty();

  /// Returns `true` if all elements match the given [predicate].
  bool all(bool Function(E) predicate) {
    if (isNullOrEmpty) return true;
    for (final element in this) {
      if (!predicate(element)) return false;
    }
    return true;
  }
}

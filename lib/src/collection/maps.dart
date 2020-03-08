part of wedzera.collection;

/// Extension library for [Iterable]
extension Maps<K, V> on Map<K, V> {
  /// Returns `true` if this nullable map is either null or empty.
  bool get isNullOrEmpty => this == null || isEmpty;
}

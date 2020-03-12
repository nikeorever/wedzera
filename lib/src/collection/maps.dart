part of wedzera.collection;

/// Extension library for [Iterable]
extension Maps<K, V> on Map<K, V> {
  /// Returns `true` if this nullable map is either null or empty.
  bool get isNullOrEmpty => this == null || isEmpty;

  /// Returns a fixed-length list containing the results of applying the given
  /// [transform] function to each entry in the original map.
  List<R> mapToList<R>(R Function(K k, V v) transform) {
    final destination = <R>[];
    for (final entry in entries) {
      destination.add(transform(entry.key, entry.value));
    }
    return destination.toList(growable: false);
  }

  /// Returns the value for the given key, or the result of the [defaultValue]
  /// function if there was no entry for the given key.
  V getOrElse(K key, V Function() defaultValue) => this[key] ?? defaultValue();
}

/// Converts [MapEntry] to [Pair] with key being first component and value being second.
Pair<K, V> mapEntryToPair<K, V>(MapEntry<K, V> entry) =>
    Pair(entry.key, entry.value);

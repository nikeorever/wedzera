part of wedzera.collection;

/// Extension class for [Iterable]
extension Maps<K, V> on Map<K, V> {
  /// Returns `true` if this nullable map is either null or empty.
  bool get isNullOrEmpty => this == null || isEmpty;

  /// Returns the value for the given key, or the result of the [defaultValue]
  /// function if there was no entry for the given key.
  V getOrElse(K key, V Function() defaultValue) => this[key] ?? defaultValue();

  /// Returns the value for the given key. If the key is not found in the map, calls the [defaultValue] function,
  /// puts its result into the map under the given key and returns it.
  V getOrPut(K key, V Function() defaultValue) {
    final value = this[key];
    if (value == null) {
      final answer = defaultValue();
      this[key] = answer;
      return answer;
    } else {
      return value;
    }
  }

  /// Returns `true` if all entries match the given [predicate].
  bool all(bool Function(MapEntry<K, V>) predicate) {
    if (isEmpty) return true;
    for (final element in entries) {
      if (!predicate(element)) {
        return false;
      }
    }
    return true;
  }

  /// Returns `true` if map has at least one entry.
  bool any() => isNotEmpty;

  /// Returns `true` if at least one entry matches the given [predicate].
  bool anyWhere(bool Function(MapEntry<K, V>) predicate) {
    if (isEmpty) return false;
    for (final element in entries) {
      if (predicate(element)) {
        return true;
      }
    }
    return false;
  }

  /// Returns the number of entries int this map.
  int count() => length;

  /// Returns the number of entries matching the given [predicate].
  int countWhere(bool Function(MapEntry<K, V>) predicate) {
    if (isEmpty) return 0;
    var count = 0;
    forEach((key, value) {
      if (predicate(MapEntry(key, value))) {
        ++count;
      }
    });
    return count;
  }

  /// Returns `true` if the map has no entries.
  bool none() => isEmpty;

  /// Returns `true` if no entries match the given [predicate].
  bool noneWhere(bool Function(MapEntry<K, V>) predicate) {
    if (isEmpty) return true;
    for (final element in entries) {
      if (predicate(element)) {
        return false;
      }
    }
    return true;
  }

  /// Performs the given [action] on each entry and returns the map itself afterwards.
  Map<K, V> onEach(void Function(MapEntry<K, V>) action) {
    forEach((key, value) => action(MapEntry(key, value)));
    return this;
  }
}

/// Converts [MapEntry] to [Pair] with key being first component and value being second.
Pair<K, V> mapEntryToPair<K, V>(MapEntry<K, V> entry) =>
    Pair(entry.key, entry.value);

part of wedzera.collection;

/// A class representing a value from a collection, along with its index in that collection.
class IndexedValue<T> {
  IndexedValue(this.index, this.value);

  /// the index of the value in the collection.
  final int index;

  /// the underlying value.
  final T value;

  @override
  String toString() => 'IndexedValue(index=$index, value=$value)';
}

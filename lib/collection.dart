library wedzera.collection;

import 'package:quiver/check.dart';
import 'package:wedzera/core.dart';
import 'package:wedzera/src/collection/internal/iterables.dart';

part 'src/collection/iterables.dart';

part 'src/collection/maps.dart';

/// Creates a new unmodifiable list with the specified [size], where each element is calculated by calling the specified
/// [init] function.
///
/// The function [init] is called for each list element sequentially starting from the first one.
/// It should return the value for a list element given its index.
List<T> list<T>(int size, T Function(int index) init) {
  final list = <T>[];
  repeat(size, (index) => list.add(init(index)));
  return List.unmodifiable(list);
}

/// Creates a new mutable list with the specified [size], where each element is calculated by calling the specified
/// [init] function.
///
/// The function [init] is called for each list element sequentially starting from the first one.
/// It should return the value for a list element given its index.
List<T> mutableList<T>(int size, T Function(int index) init) {
  final list = <T>[];
  repeat(size, (index) => list.add(init(index)));
  return list;
}

/// Returns a new unmodifiable [Map] with the specified contents, given as a list of pairs
/// where the first component is the key and the second is the value.
///
/// If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
///
/// Entries of the map are iterated in the order they were specified.
///
Map<K, V> mapOf<K, V>(Iterable<Pair<K, V>> pairs) {
  return Map.unmodifiable(
      Map.fromEntries(pairs.map((pair) => pair.toMapEntry())));
}

/// Returns a new [Map] with the specified contents, given as a list of pairs
/// where the first component is the key and the second is the value.
///
/// If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
///
/// Entries of the map are iterated in the order they were specified.
///
Map<K, V> mutableMapOf<K, V>(Iterable<Pair<K, V>> pairs) {
  return Map.fromEntries(pairs.map((pair) => pair.toMapEntry()));
}

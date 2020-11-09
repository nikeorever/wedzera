library wedzera.collection;

import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:wedzera/core.dart';
import 'package:wedzera/src/collection/internal/iterables.dart';

part 'src/collection/grouping.dart';
part 'src/collection/IndexedValue.dart';
part 'src/collection/iterables.dart';
part 'src/collection/maps.dart';

/// Creates a new unmodifiable list with the specified [size], where each element is calculated by calling the specified
/// [init] function.
///
/// The function [init] is called for each list element sequentially starting from the first one.
/// It should return the value for a list element given its index.
List<T> unmodifiableList<T>(int size, T Function(int index) init) {
  final mutableList = <T>[];
  repeat(size, (index) => mutableList.add(init(index)));
  return mutableList.toUnmodifiableList();
}

/// Creates a new mutable list with the specified [size], where each element is calculated by calling the specified
/// [init] function.
///
/// The function [init] is called for each list element sequentially starting from the first one.
/// It should return the value for a list element given its index.
List<T> mutableList<T>(int size, T Function(int index) init) {
  final mutableList = <T>[];
  repeat(size, (index) => mutableList.add(init(index)));
  return mutableList;
}

/// Returns a new unmodifiable [Map] with the specified contents, given as a list of pairs
/// where the first component is the key and the second is the value.
///
/// If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
///
/// Entries of the map are iterated in the order they were specified.
///
Map<K, V> unmodifiableMapOf<K, V>(Iterable<Pair<K, V>> pairs) {
  return Map.fromEntries(pairs.map((pair) => pair.toMapEntry()))
      .toUnmodifiableMap();
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

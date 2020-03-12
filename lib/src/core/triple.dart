part of wedzera.core;

/// Represents a generic pair of two values.
///
/// [A] type of the first value.
/// [B] type of the second value.
/// [first] first value.
/// [second] second value.
class Pair<A, B> {
  Pair(this.first, this.second);

  final A first;
  final B second;

  /// Converts [Pair] to [MapEntry]
  MapEntry<A, B> toMapEntry() => MapEntry(first, second);

  /// Returns string representation of the [Pair] including its [first]
  /// and [second] values.
  @override
  String toString() => '($first, $second)';
}

/// Converts this pair into a list.
List<T> parsePairAsMutableList<T>(Pair<T, T> pair) => [pair.first, pair.second];

/// Represents a triad of values
///
/// [A] type of the first value.
/// [B] type of the second value.
/// [C] type of the third value.
/// [first] first value.
/// [second] second value.
/// [third] third value.
class Triple<A, B, C> {
  Triple(this.first, this.second, this.third);

  final A first;
  final B second;
  final C third;

  /// Returns string representation of the [Triple] including its [first],
  /// [second] and [third] values.
  @override
  String toString() => '($first, $second, $third)';
}

/// Converts this triple into a list.
List<T> parseTripleAsMutableList<T>(Triple<T, T, T> triple) =>
    [triple.first, triple.second, triple.third];

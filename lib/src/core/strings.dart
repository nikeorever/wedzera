part of wedzera.core;

void main() {}

extension Strings on String {
  /// Returns `true` if this nullable String is either `null` or empty.
  bool isNullOrEmpty() => this == null || isEmpty;

  ///Returns the string if it is not `null`, or the empty string otherwise.
  String orEmpty() => this ?? '';

  /// Returns this String if it's not empty
  /// or the result of calling [defaultValue] function if the String is empty.
  String ifEmpty(String Function() defaultValue) =>
      isEmpty ? defaultValue() : this;

  /// Returns `true` if this string is empty or consists solely of whitespace characters.
  bool get isBlank => trim().isEmpty;

  /// Returns `true` if this nullable String is either `null` or empty or consists solely of whitespace characters.
  bool isNullOrBlank() => this == null || isBlank;

  /// Returns this string if it's not null, not empty and is not solely
  /// made of whitespace characters (as defined by [String.trim]) or this result
  /// of calling [defaultValue] function
  String ifBlank(String Function() defaultValue) =>
      isBlank ? defaultValue() : this;

  /// Parses the string as an [int] number and returns the result.
  ///
  /// For nullable string, You should do as follow:
  /// ```dart
  /// nullableStr?.toInt()
  /// ```
  /// Throws a [RangeError] if [radix] is not a valid radix[2..36] for string to number conversion.
  /// Throws a [FormatException] if the string is not a valid representation of a number.
  /// Throws a [ArgumentError] if string is `null`.
  int toInt({int radix = 10}) {
    requireNotNull(this);
    return int.parse(this, radix: radix);
  }

  /// Parses the string as an [int] number and returns the result
  /// or `null` if the string is not a valid representation of a number.
  ///
  /// For nullable string, You should do as follow:
  /// ```dart
  /// nullableStr?.toIntOrNull()
  /// ```
  /// Throws a [RangeError] if [radix] is not a valid radix[2..36] for string to number conversion.
  /// Throws a [ArgumentError] if string is `null`.
  int toIntOrNull({int radix = 10}) {
    requireNotNull(this);
    return int.tryParse(this, radix: radix);
  }

  /// Parses the string as a [double] number and returns the result.
  ///
  /// For nullable string, You should do as follow:
  /// ```dart
  /// nullableStr?.toDouble()
  /// ```
  /// Throws a [FormatException] if the string is not a valid representation of a number.
  /// Throws a [ArgumentError] if string is `null`.
  double toDouble() {
    requireNotNull(this);
    return double.parse(this);
  }

  /// Parses the string as a [double] number and returns the result
  /// or `null` if the string is not a valid representation of a number.
  ///
  /// For nullable string, You should do as follow:
  /// ```dart
  /// nullableStr?.toDoubleOrNull()
  /// ```
  /// Throws a [ArgumentError] if string is `null`.
  double toDoubleOrNull() {
    requireNotNull(this);
    return double.tryParse(this);
  }
}

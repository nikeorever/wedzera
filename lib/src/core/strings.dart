part of wedzera.core;

extension Strings on String {
  ///Returns the string if it is not `null`, or the empty string otherwise.
  String orEmpty() => this ?? '';

  /// Returns this string if it's neither null nor empty
  /// or this result of calling [defaultValue] function
  String ifEmpty(String Function() defaultValue) =>
      isEmpty(this) ? defaultValue() : this;

  /// Returns this string if it's not null, not empty and is not solely
  /// made of whitespace characters (as defined by [String.trim]) or this result
  /// of calling [defaultValue] function
  String ifBlank(String Function() defaultValue) =>
      isBlank(this) ? defaultValue() : this;

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
    checkNotNull(this);
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
    checkNotNull(this);
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
    checkNotNull(this);
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
    checkNotNull(this);
    return double.tryParse(this);
  }
}

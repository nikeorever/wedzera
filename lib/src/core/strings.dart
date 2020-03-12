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
}

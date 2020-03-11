part of wedzera.core;

extension Strings on String {
  ///Returns the string if it is not `null`, or the empty string otherwise.
  String orEmpty() => this ?? '';
}

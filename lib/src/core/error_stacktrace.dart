part of wedzera.core;

/// An Object which containing both an error and the corresponding stack trace.
class ErrorAndStacktrace {
  /// Constructs an object containing both an [error] and the
  /// corresponding [stackTrace].
  ErrorAndStacktrace(this.error, this.stackTrace);

  /// A reference to the wrapped error object.
  final dynamic error;

  /// A reference to the wrapped [StackTrace]
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'ErrorAndStacktrace{error: $error, stacktrace: $stackTrace}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorAndStacktrace &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          stackTrace == other.stackTrace;

  @override
  int get hashCode => error.hashCode ^ stackTrace.hashCode;
}

part of wedzera.core;

/// A discriminated union that encapsulates a successful outcome with a value of type [T]
/// or a failure with an arbitrary [Exception] exception.
class Result<T> {
  Result(this.value);

  final Object value;

  bool get isSuccess => !(value is Failure);

  bool get isFailure => value is Failure;

  /// Returns the encapsulated value if this instance represents [success][Result.isSuccess] or `null`
  /// if it is [failure][Result.isFailure].
  ///
  /// This function is a shorthand for `getOrElse { null }` (see [getOrElse]) or
  /// `fold(onSuccess = { it }, onFailure = { null })` (see [fold]).
  T getOrNull() {
    if (isFailure) {
      return null;
    } else {
      return value;
    }
  }

  /// Returns the encapsulated [Exception] exception if this instance represents [failure][isFailure] or `null`
  /// if it is [success][isSuccess].
  ///
  /// This function is a shorthand for `fold(onSuccess = { null }, onFailure = { it })` (see [fold]).
  Exception exceptionOrNull() {
    final v = value;
    if (v is Failure) {
      return v.exception;
    } else {
      return null;
    }
  }

  @override
  String toString() {
    if (value is Failure) {
      return value.toString();
    } else {
      return 'Success($value)';
    }
  }

  /// Throws exception if the result is failure.
  void throwOnFailure() {
    final v = value;
    if (v is Failure) {
      throw v.exception;
    }
  }

  /// Returns the encapsulated value if this instance represents [success][Result.isSuccess] or the
  /// result of [onFailure] function for the encapsulated [Exception] exception if it is [failure][Result.isFailure].
  ///
  /// Note, that this function rethrows any [Exception] exception thrown by [onFailure] function.
  ///
  /// This function is a shorthand for `fold(onSuccess = { it }, onFailure = onFailure)` (see [fold]).
  T getOrElse(T onFailure(Exception exception)) {
    var exception = exceptionOrNull();
    if (exception == null) {
      return value;
    } else {
      return onFailure(exception);
    }
  }

  /// Returns the encapsulated value if this instance represents [success][Result.isSuccess] or the
  /// [defaultValue] if it is [failure][Result.isFailure].
  ///
  /// This function is a shorthand for `getOrElse { defaultValue }` (see [getOrElse]).
  T getOrDefault(T defaultValue) {
    if (isFailure) return defaultValue;
    return value;
  }

  /// Returns the encapsulated value if this instance represents [success][Result.isSuccess] or throws the encapsulated [Exception] exception
  /// if it is [failure][Result.isFailure].
  ///
  /// This function is a shorthand for `getOrElse { throw it }` (see [getOrElse]).
  T getOrThrow() {
    throwOnFailure();
    return value;
  }

  /// Returns the encapsulated result of the given [transform] function applied to the encapsulated value
  /// if this instance represents [success][Result.isSuccess] or the
  /// original encapsulated [Exception] exception if it is [failure][Result.isFailure].
  ///
  /// Note, that this function rethrows any [Throwable] exception thrown by [transform] function.
  /// See [mapCatching] for an alternative that encapsulates exceptions.
  Result<R> map<R>(R transform(T value)) {
    if (isSuccess) {
      return Result.success(transform(value));
    } else {
      return Result(value);
    }
  }

  /// Returns the encapsulated result of the given [transform] function applied to the encapsulated value
  /// if this instance represents [success][Result.isSuccess] or the
  /// original encapsulated [Exception] exception if it is [failure][Result.isFailure].
  ///
  /// This function catches any [Exception] exception thrown by [transform] function and encapsulates it as a failure.
  /// See [map] for an alternative that rethrows exceptions from `transform` function.
  Result<R> mapCatching<R>(R transform(T value)) {
    if (isSuccess) {
      return runCatching(() => transform(value));
    } else {
      return Result(value);
    }
  }

  /// Returns the the result of [onSuccess] for encapsulated value if this instance represents [success][Result.isSuccess]
  /// or the result of [onFailure] function for encapsulated exception if it is [failure][Result.isFailure].
  /// Note, that an exception thrown by [onSuccess] or by [onFailure] function is rethrown by this function.
  R fold<R>(R onSuccess(T value), R onFailure(Exception exception)) {
    var exception = exceptionOrNull();
    if (exception == null) {
      return onSuccess(value);
    } else {
      return onFailure(exception);
    }
  }

  /// Performs the given [action] on the encapsulated [Exception] exception
  /// if this instance represents [failure][Result.isFailure].
  /// Returns the original `Result` unchanged.
  Result<T> onFailure(action(Exception exception)) {
    var exception = exceptionOrNull();
    if (exception != null) {
      action(exception);
    }
    return this;
  }

  /// Performs the given [action] on the encapsulated value if this instance
  /// represents [success][Result.isSuccess].
  /// Returns the original `Result` unchanged.
  Result<T> onSuccess(action(T value)) {
    if (isSuccess) {
      action(value);
    }
    return this;
  }

  /// Returns an instance that encapsulates the given [value] as successful value.
  static Result<T> success<T>(T value) => Result(value);

  /// Returns an instance that encapsulates the given [Exception] [exception] as failure.
  static Result<T> failure<T>(Exception exception) =>
      Result(_createFailure(exception));
}

class Failure {
  Failure(this.exception);

  final Exception exception;

  @override
  bool operator ==(other) {
    return other is Failure && exception == other.exception;
  }

  @override
  int get hashCode => exception.hashCode;

  @override
  String toString() {
    return 'Failure($exception)';
  }
}

Object _createFailure(Exception exception) => Failure(exception);

/// Calls the specified function [block] and returns its encapsulated result
/// if invocation was successful, catching and encapsulating any thrown
/// exception as a failure.
Result<R> runCatching<R>(R block()) {
  try {
    return Result.success(block());
  } catch (e) {
    return Result.failure(e);
  }
}

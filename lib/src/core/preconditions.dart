part of wedzera.core;

/// Throws an [ArgumentError] with the result of calling [lazyMessage] if the [value] is false.
void require(bool value, {Object Function() lazyMessage}) {
  if (!value) {
    final message = lazyMessage?.call() ?? 'Failed requirement.';
    throw ArgumentError(message.toString());
  }
}

/// Throws an [ArgumentError] with the result of calling [lazyMessage] if the [value] is null. Otherwise
/// returns the not null value.
T requireNotNull<T>(T value, {Object Function() lazyMessage}) {
  if (value == null) {
    final message = lazyMessage?.call() ?? 'Required value was null.';
    throw ArgumentError(message.toString());
  } else {
    return value;
  }
}

/// Throws an [StateError] with the result of calling [lazyMessage] if the [value] is false.
void check(bool value, {Object Function() lazyMessage}) {
  if (!value) {
    final message = lazyMessage?.call() ?? 'Check failed.';
    throw StateError(message.toString());
  }
}

/// Throws an [StateError] with the result of calling [lazyMessage]  if the [value] is null. Otherwise
/// returns the not null value.
T checkNotNull<T>(T value, {Object Function() lazyMessage}) {
  if (value == null) {
    final message = lazyMessage?.call() ?? 'Required value was null.';
    throw StateError(message.toString());
  } else {
    return value;
  }
}

/// Throws an [StateError] with the given [message].
void error(Object message) => throw StateError(message.toString());

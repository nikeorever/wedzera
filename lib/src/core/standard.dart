part of wedzera.core;

extension Any<T> on T {
  /// Calls the specified function [block] with `this` value as its argument and returns `this` value.
  T also(void Function(T) block) {
    block(this);
    return this;
  }

  /// Calls the specified function [block] with `this` value as its argument and returns its result.
  R let<R>(R Function(T) block) {
    return block(this);
  }

  /// Returns `this` value if it satisfies the given [predicate] or `null`, if it doesn't.
  T takeIf(bool Function(T) predicate) {
    if (predicate(this)) {
      return this;
    } else {
      return null;
    }
  }

  /// Returns `this` value if it _does not_ satisfy the given [predicate] or `null`, if it does.
  T takeUnless(bool Function(T) predicate) {
    if (!predicate(this)) {
      return this;
    } else {
      return null;
    }
  }
}

/// Calls the specified function [block] and returns its result.
R run<R>(R Function() block) {
  return block();
}

/// Executes the given function [action] specified number of [times].
/// A zero-based index of current iteration is passed as a parameter to [action].
void repeat(int times, Function(int) action) {
  for (var index = 0; index < times; index++) {
    action(index);
  }
}

/// Always throws [UnimplementedError] stating that operation is not implemented.
/// [reason] a string explaining why the implementation is missing.
// ignore: non_constant_identifier_names
void TODO([String reason]) => throw UnimplementedError(isNotEmpty(reason)
    ? 'An operation is not implemented: $reason'
    : 'An operation is not implemented.');

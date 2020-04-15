part of wedzera.core;

extension NumRanges<T extends num> on T {
  /// Ensures that this value is not less than the specified [minimumValue].
  ///
  /// return this value if it's greater than or equal to the [minimumValue] or the [minimumValue] otherwise.
  T coerceAtLeast(T minimumValue) {
    if (this < minimumValue) {
      return minimumValue;
    } else {
      return this;
    }
  }

  /// Ensures that this value is not greater than the specified [maximumValue].
  ///
  /// return this value if it's less than or equal to the [maximumValue] or the [maximumValue] otherwise.
  T coerceAtMost(T maximumValue) {
    if (this > maximumValue) {
      return maximumValue;
    } else {
      return this;
    }
  }

  /// Ensures that this value lies in the specified range [minimumValue]..[maximumValue].
  ///
  /// return this value if it's in the range, or [minimumValue] if this value is less than [minimumValue], or [maximumValue] if this value is greater than [maximumValue].
  T coerceIn(T minimumValue, T maximumValue) {
    checkArgument(minimumValue <= maximumValue,
        message:
            'Cannot coerce value to an empty range: maximum $maximumValue is less than minimum $minimumValue.');
    if (this < minimumValue) return minimumValue;
    if (this > maximumValue) return maximumValue;
    return this;
  }
}

extension ComparableRanges<T extends Comparable<T>> on T {
  /// Ensures that this value is not less than the specified [minimumValue].
  ///
  /// return this value if it's greater than or equal to the [minimumValue] or the [minimumValue] otherwise.
  T coerceAtLeast(T minimumValue) {
    if (compareTo(minimumValue) < 0) {
      return minimumValue;
    } else {
      return this;
    }
  }

  /// Ensures that this value is not greater than the specified [maximumValue].
  ///
  /// return this value if it's less than or equal to the [maximumValue] or the [maximumValue] otherwise.
  T coerceAtMost(T maximumValue) {
    if (compareTo(maximumValue) > 0) {
      return maximumValue;
    } else {
      return this;
    }
  }

  /// Ensures that this value lies in the specified range [minimumValue]..[maximumValue].
  ///
  /// return this value if it's in the range, or [minimumValue] if this value is less than [minimumValue], or [maximumValue] if this value is greater than [maximumValue].
  T coerceIn(T minimumValue, T maximumValue) {
    if (minimumValue != null && maximumValue != null) {
      checkArgument(minimumValue.compareTo(maximumValue) <= 0,
          message:
              'Cannot coerce value to an empty range: maximum $maximumValue is less than minimum $minimumValue.');
      if (compareTo(minimumValue) < 0) return minimumValue;
      if (compareTo(maximumValue) > 0) return maximumValue;
    } else {
      if (minimumValue != null && compareTo(minimumValue) < 0) {
        return minimumValue;
      }
      if (maximumValue != null && compareTo(maximumValue) > 0) {
        return maximumValue;
      }
    }
    return this;
  }
}

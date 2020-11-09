part of wedzera.core;

/// Executes the given [block] and returns elapsed time in milliseconds.
int measureTimeMillis(Function() block) {
  final start = DateTime.now().millisecondsSinceEpoch;
  block();
  return DateTime.now().millisecondsSinceEpoch - start;
}

/// Executes the given [block] and returns elapsed time in microseconds.
int measureTimeMicros(Function() block) {
  final start = DateTime.now().microsecondsSinceEpoch;
  block();
  return DateTime.now().microsecondsSinceEpoch - start;
}

library wedzera.time;

/// Executes the given [block] and returns elapsed time in milliseconds.
int measureTimeMillis(Function() block) {
  final start = DateTime.now().millisecond;
  block();
  return DateTime.now().millisecond - start;
}

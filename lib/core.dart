library wedzera.core;

part 'src/core/triple.dart';
part 'src/core/result.dart';

/// Executes the given function [action] specified number of [times].
/// A zero-based index of current iteration is passed as a parameter to [action].
void repeat(int times, Function(int) action) {
  for (var index = 0; index < times; index++) {
    action(index);
  }
}

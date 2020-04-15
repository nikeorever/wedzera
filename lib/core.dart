library wedzera.core;

import 'package:wedzera/collection.dart';
import 'package:quiver/strings.dart';
import 'package:quiver/check.dart';

part 'src/core/error_stacktrace.dart';
part 'src/core/predicates.dart';
part 'src/core/ranges.dart';
part 'src/core/result.dart';
part 'src/core/strings.dart';
part 'src/core/transformations.dart';
part 'src/core/triple.dart';

/// Executes the given function [action] specified number of [times].
/// A zero-based index of current iteration is passed as a parameter to [action].
void repeat(int times, Function(int) action) {
  for (var index = 0; index < times; index++) {
    action(index);
  }
}

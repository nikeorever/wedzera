import 'package:quiver/check.dart';

enum _State { Ready, NotReady, Done, Failed }

/// A base class to simplify implementing iterators so that implementations only have to implement [computeNext]
/// to implement the iterator, calling [done] when the iteration is complete.
abstract class AbstractIterator<T> extends Iterator<T> {
  var _state = _State.NotReady;
  T _nextValue;

  @override
  T get current {
    if (!moveNext()) throw StateError('no such element');
    _state = _State.NotReady;
    return _nextValue;
  }

  @override
  bool moveNext() {
    checkArgument(_state != _State.Failed);
    switch (_state) {
      case _State.Done:
        return false;
      case _State.Ready:
        return true;
      default:
        return _tryToComputeNext();
    }
  }

  bool _tryToComputeNext() {
    _state = _State.Failed;
    computeNext();
    return _state == _State.Ready;
  }

  /// Computes the next item in the iterator.
  ///
  /// This callback method should call one of these two methods:
  ///
  /// * [setNext] with the next value of the iteration
  /// * [done] to indicate there are no more elements
  ///
  /// Failure to call either method will result in the iteration terminating with a failed state
  void computeNext();

  /// Sets the next value in the iteration, called from the [computeNext] function
  void setNext(T value) {
    _nextValue = value;
    _state = _State.Ready;
  }

  /// Sets the state to done so that the iteration terminates.
  void done() => _state = _State.Done;
}

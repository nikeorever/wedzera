typedef _IndexedElementPredicate<E> = bool Function(int index, E);

class WhereIndexedIterable<E> extends Iterable<E> {
  WhereIndexedIterable(this._iterable, this._f);

  final Iterable<E> _iterable;
  final _IndexedElementPredicate<E> _f;

  @override
  Iterator<E> get iterator => WhereIndexedIterator(_iterable.iterator, _f);
}

class WhereIndexedIterator<E> extends Iterator<E> {
  WhereIndexedIterator(this._iterator, this._f);

  final Iterator<E> _iterator;
  final _IndexedElementPredicate<E> _f;
  var _index = 0;

  @override
  bool moveNext() {
    while (_iterator.moveNext()) {
      if (_f(_index++, _iterator.current)) {
        return true;
      }
    }
    return false;
  }

  @override
  E get current => _iterator.current;
}

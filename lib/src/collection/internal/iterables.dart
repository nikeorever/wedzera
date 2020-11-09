import 'dart:collection';

import 'package:wedzera/collection.dart';
import 'package:wedzera/src/collection/internal/abstract_iterator.dart';

typedef _IndexedElementPredicate<E> = bool Function(int index, E);

class WhereIndexedIterable<E> extends Iterable<E> {
  WhereIndexedIterable(this._iterable, this._f);

  final Iterable<E> _iterable;
  final _IndexedElementPredicate<E> _f;

  @override
  Iterator<E> get iterator => _WhereIndexedIterator(_iterable.iterator, _f);
}

class _WhereIndexedIterator<E> extends Iterator<E> {
  _WhereIndexedIterator(this._iterator, this._f);

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

class DistinctIterable<T, K> extends Iterable<T> {
  DistinctIterable(this._source, this._keySelector);

  final Iterable<T> _source;
  final K Function(T) _keySelector;

  @override
  Iterator<T> get iterator => _DistinctIterator(_source.iterator, _keySelector);
}

class _DistinctIterator<T, K> extends AbstractIterator<T> {
  _DistinctIterator(this._source, this._keySelector);

  final Iterator<T> _source;
  final K Function(T) _keySelector;
  final Set<K> _observed = HashSet<K>();

  @override
  void computeNext() {
    while (_source.moveNext()) {
      final next = _source.current;
      final key = _keySelector(next);

      if (_observed.add(key)) {
        setNext(next);
        return;
      }
    }
    done();
  }
}

class IndexingIterable<E> extends Iterable<IndexedValue<E>> {
  IndexingIterable(this._iterable);

  final Iterable<E> _iterable;

  @override
  Iterator<IndexedValue<E>> get iterator =>
      _IndexingIterator<E>(_iterable.iterator);
}

class _IndexingIterator<E> extends Iterator<IndexedValue<E>> {
  _IndexingIterator(this._iterator);

  final Iterator<E> _iterator;
  var index = 0;

  @override
  IndexedValue<E> get current => IndexedValue(index++, _iterator.current);

  @override
  bool moveNext() => _iterator.moveNext();
}

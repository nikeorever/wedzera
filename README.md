Wedzera
======

Wedzera is an extension toolkit for Dart, It contains many convenient, functional, and easy-to-use functions.

Libraries
--------------

## [wedzera.collection][]

`MutableList` creates a new mutable list with the specified size, where each element is calculated by calling the specified init function.

`mapOf` Returns a new `Map` with the specified contents, given as a list of pairs where the first component is the key and the second is the value.

`Iterables` is an extension library for `Iterable`.

`Maps` is an extension library for `Map`.

[wedzera.collection]: https://pub.dev/documentation/wedzera/latest/wedzera.collection/wedzera.collection-library.html

## [wedzera.core][]

`Pair` represents a generic pair of two values.

`parsePairAsList` converts this pair into a list.

`toMapEntry` converts `Pair` to `MapEntry`.

`Triple` represents a triad of values.

`parseTripleAsList` converts this triple into a list.

`Result` a discriminated union that encapsulates a successful outcome with a value of type T or a failure with an arbitrary `Exception` exception.

`repeat` executes the given function action specified number of times.

[wedzera.core]: https://pub.dev/documentation/wedzera/latest/wedzera.core/wedzera.core-library.html

## [wedzera.time][]

`measureTimeMillis` executes the given block and returns elapsed time in milliseconds.

[wedzera.time]: https://pub.dev/documentation/wedzera/latest/wedzera.time/wedzera.time-library.html

# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0] - 2020-03-22

### Added

- Extend a lot of practical methods for Iterable/Map,
these methods can make you more convenient for functional programming,
such as Iterable#scan, Iterable#groupingBy, Map#getOrPut, etc.

- Added some map/filter static methods commonly used in functional programming.

- Extend a lot of practical methods for String, such as String#toIntOrNull, etc.

- Added Pair/Triple class and added its conversion function to Map(MapEntry)/List.

- Added Result class.

- Added ErrorAndStacktrace class.

- In order to more easily detect the execution time of code blocks,
you can use measureTimeMillis() or measureTimeMicros().

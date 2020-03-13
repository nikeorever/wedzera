## 0.0.2 - 2020-03-13
### Added
- Add wedzera.system
- Add measureTimeMicros()
- Add ErrorAndStacktrace class
- Add extension methods for Iterable
- Add extension methods for Map
### Removed
- Remove wedzera.time


## 0.0.1+4 - 2020-03-12
### Added
- Add toInt()/toIntOrNull(), toDouble()/toDoubleOrNull() in String extension
### Changed
- Map#mapToList() return an unmodifiable list instead of fixed-length list now
- pairToList() return an unmodifiable list instead of fixed-length list now
- tripleToList() return an unmodifiable list instead of fixed-length list now
- list represent unmodifiable list, mutableList represent mutable list


## 0.0.1+3 - 2020-03-12
### Changed
- Change mapToMutableList() to mapToList() in maps.dart, FIXED-LENGTH list will be returned
- Change parseMapEntryAsPair() to mapEntryToPair() in maps.dart


## 0.0.1+2 - 2020-03-12
### Added
- Add runCatchingAsync() for async support in result.dart
- Add ifEmpty() in Strings extension
- Add ifBlank() in Strings extension
- Add toMapEntry() in Pair class
### Changed
- Change parsePairAsMutableList() to pairToList() in triple.dart, FIXED-LENGTH list will be returned
- Change parseTripleAsMutableList() to tripleToList() in triple.dart, FIXED-LENGTH list will be returned
### Removed
- Remove parsePairAsMapEntry() in triple.dart


## 0.0.1+1 - 2020-03-08
### Added
- Add Result class
- Add Pair/Triple class
- Add measureTimeMillis() method
- Add repeat() method
- Add MutableList() method
- Add mapOf() method
- Increase api of Iterables
- Increase api of Maps

   
## 0.0.1 - 2020-03-08
- Initial version.

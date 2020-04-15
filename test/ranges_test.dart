import 'package:test/test.dart';
import 'package:wedzera/core.dart';

void main() {
  group('ranges test', () {
    test('[num] ranges test', () {
      const int4 = 4;
      const int5 = 5;
      const int9 = 9;
      const int10 = 10;
      expect(int10.coerceAtLeast(int5), equals(int10));
      expect(int5.coerceAtLeast(int5), equals(int5));
      expect(int4.coerceAtLeast(int5), equals(int5));

      expect(int10.coerceAtMost(int9), equals(int9));
      expect(int9.coerceAtMost(int9), equals(int9));
      expect(int5.coerceAtMost(int9), equals(int5));

      expect(int5.coerceIn(int4, int10), equals(int5));
      expect(int4.coerceIn(int5, int10), equals(int5));
      expect(int10.coerceIn(int5, int9), equals(int9));
      expect(int10.coerceIn(int5, int5), equals(int5));
      expect(int5.coerceIn(int5, int5), equals(int5));
      expect(() => int10.coerceIn(int9, int5), throwsArgumentError);
    });
    test('[Comparable] ranges test', () {
      const day4 = Duration(days: 4);
      const day5 = Duration(days: 5);
      const day9 = Duration(days: 9);
      const day10 = Duration(days: 10);
      expect(day10.coerceAtLeast(day5).inDays, equals(day10.inDays));
      expect(day5.coerceAtLeast(day5).inDays, equals(day5.inDays));
      expect(day4.coerceAtLeast(day5).inDays, equals(day5.inDays));

      expect(day10.coerceAtMost(day9).inDays, equals(day9.inDays));
      expect(day9.coerceAtMost(day9).inDays, equals(day9.inDays));
      expect(day5.coerceAtMost(day9).inDays, equals(day5.inDays));

      expect(day5.coerceIn(day4, day10).inDays, equals(day5.inDays));
      expect(day4.coerceIn(day5, day10).inDays, equals(day5.inDays));
      expect(day10.coerceIn(day5, day9).inDays, equals(day9.inDays));
      expect(day10.coerceIn(day5, day5).inDays, equals(day5.inDays));
      expect(day5.coerceIn(day5, day5).inDays, equals(day5.inDays));
      expect(() => day10.coerceIn(day9, day5).inDays, throwsArgumentError);
    });
  });
}

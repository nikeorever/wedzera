import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:wedzera/core.dart';

class MyBenchmark extends BenchmarkBase {
  MyBenchmark() : super('MyBenchmark');

  static void main() {
    MyBenchmark().report();
  }

  @override
  void setup() {
  }

  @override
  void run() {
    final list = <int>[];
    repeat(1000000000, (index) {
      list.add(index);
    });

    final acc = list.map((ele) => ele + 1)
        .where((ele)=> ele % 2 == 0)
        .fold(0, (acc, ele) => acc + ele);
    print(acc);
  }

  @override
  void teardown() {
  }
}

void main() {
  MyBenchmark.main();
}
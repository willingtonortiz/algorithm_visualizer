import 'package:algorithm_visualizer/algorithms/binary_search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Binary Search',
    () {
      //             0  1  2  3  4  5  6  7  8  9
      final items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

      expect(binarySearch(items, -10), null);
      expect(binarySearch(items, 1), 0);
      expect(binarySearch(items, 2), 1);
      expect(binarySearch(items, 3), 2);
      expect(binarySearch(items, 4), 3);
      expect(binarySearch(items, 5), 4);
      expect(binarySearch(items, 6), 5);
      expect(binarySearch(items, 7), 6);
      expect(binarySearch(items, 8), 7);
      expect(binarySearch(items, 9), 8);
      expect(binarySearch(items, 10), 9);
      expect(binarySearch(items, 20), null);
    },
  );
}

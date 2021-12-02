int? binarySearch(List<int> list, int value) {
  int left = 0;
  int right = list.length - 1;

  while (left <= right) {
    final middle = (right + left + 1) ~/ 2;
    final item = list[middle];

    if (item == value) {
      return middle;
    } else if (item < value) {
      left = middle + 1;
    } else {
      right = middle - 1;
    }
  }
}

class BinarySearchItem {
  const BinarySearchItem({
    required this.left,
    required this.right,
    required this.middle,
    required this.found,
  });

  final int left;
  final int right;
  final int middle;
  final bool found;

  @override
  String toString() =>
      'BinarySearchItem(left: $left, right: $right, middle: $middle, found: $found)';
}

Stream<BinarySearchItem> streamBinarySearch(List<int> list, int value) async* {
  int left = 0;
  int right = list.length - 1;

  while (left <= right) {
    final middle = (right + left + 1) ~/ 2;
    final item = list[middle];

    if (item == value) {
      yield BinarySearchItem(
          left: left, right: right, middle: middle, found: true);
      return;
    } else if (item < value) {
      yield BinarySearchItem(
          left: left, right: right, middle: middle, found: false);
      left = middle + 1;
    } else {
      yield BinarySearchItem(
          left: left, right: right, middle: middle, found: false);
      right = middle - 1;
    }
  }
}

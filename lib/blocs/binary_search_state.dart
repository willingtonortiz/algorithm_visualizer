enum BinarySearchStatus { initial, searching, found, notFound }

class BinarySearchState {
  BinarySearchState({
    this.items = const [],
    this.left = -1,
    this.right = -1,
    this.found = -1,
    this.potencial = -1,
    this.status = BinarySearchStatus.initial,
  });

  final BinarySearchStatus status;
  final List<int> items;
  final int left;
  final int right;
  final int potencial;
  final int found;

  BinarySearchState copyWith({
    List<int>? items,
    int? left,
    int? right,
    int? potencial,
    int? found,
    BinarySearchStatus? status,
  }) {
    return BinarySearchState(
      items: items ?? this.items,
      left: left ?? this.left,
      right: right ?? this.right,
      potencial: potencial ?? this.potencial,
      found: found ?? this.found,
      status: status ?? this.status,
    );
  }
}

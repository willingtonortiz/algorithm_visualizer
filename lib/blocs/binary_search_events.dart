abstract class BinarySearchEvent {
  const BinarySearchEvent();
}

class InitializeItems extends BinarySearchEvent {
  const InitializeItems();
}

class SearchItem extends BinarySearchEvent {
  const SearchItem({
    required this.item,
  });

  final int item;
}

class ResetItems extends BinarySearchEvent {
  const ResetItems();
}

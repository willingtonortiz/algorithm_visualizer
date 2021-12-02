import 'package:bloc/bloc.dart';

import 'package:algorithm_visualizer/blocs/binary_search_events.dart';
import 'package:algorithm_visualizer/blocs/binary_search_state.dart';

class BinarySearchBloc extends Bloc<BinarySearchEvent, BinarySearchState> {
  BinarySearchBloc() : super(BinarySearchState()) {
    on<InitializeItems>(_onInitializeItems);
    on<SearchItem>(_onSearchItem);
    on<ResetItems>(_onResetItems);
  }

  Future<void> _onInitializeItems(
    InitializeItems event,
    Emitter<BinarySearchState> emit,
  ) async {
    final initialItems = List.generate(100, (index) => index + 1);

    emit(state.copyWith(
      status: BinarySearchStatus.initial,
      items: initialItems,
      left: -1,
      right: initialItems.length,
      potencial: -1,
      found: -1,
    ));
  }

  Future<void> _onSearchItem(
    SearchItem event,
    Emitter<BinarySearchState> emit,
  ) async {
    emit(state.copyWith(
      found: -1,
      left: -1,
      right: state.items.length,
      potencial: -1,
      status: BinarySearchStatus.searching,
    ));

    final list = state.items;
    final value = event.item;
    const shortDuration = Duration(milliseconds: 500);
    const longDuration = Duration(milliseconds: 1000);

    int left = 0;
    int right = list.length - 1;

    while (left <= right) {
      final middle = (right + left + 1) ~/ 2;
      final item = list[middle];

      emit(state.copyWith(left: left, right: right));
      await wait(shortDuration);
      emit(state.copyWith(potencial: middle));
      await wait(longDuration);

      if (item == value) {
        emit(state.copyWith(
            found: middle,
            left: left,
            right: right,
            status: BinarySearchStatus.found));

        return;
      } else if (item < value) {
        left = middle + 1;
        emit(state.copyWith(left: left, right: right));

        await wait(longDuration);
      } else {
        right = middle - 1;
        emit(state.copyWith(left: left, right: right));

        await wait(longDuration);
      }
    }

    emit(state.copyWith(status: BinarySearchStatus.notFound));
  }

  Future<void> _onResetItems(
    ResetItems event,
    Emitter<BinarySearchState> emit,
  ) async {
    final initialItems = List.generate(100, (index) => index + 1);
    emit(state.copyWith(
      status: BinarySearchStatus.initial,
      items: initialItems,
      left: -1,
      right: initialItems.length,
      potencial: -1,
      found: -1,
    ));
  }

  Future<void> wait(Duration duration) async {
    await Future.delayed(duration);
  }
}

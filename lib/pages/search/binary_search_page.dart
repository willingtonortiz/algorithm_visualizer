import 'package:algorithm_visualizer/blocs/binary_search_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import 'package:algorithm_visualizer/blocs/binary_search_bloc.dart';
import 'package:algorithm_visualizer/blocs/binary_search_state.dart';

extension IsBetween on num {
  bool isBetween(num a, num b) {
    return a <= this && this <= b;
  }
}

class BinarySearchPage extends StatefulWidget {
  const BinarySearchPage({Key? key}) : super(key: key);

  @override
  State<BinarySearchPage> createState() => _BinarySearchPageState();
}

class _BinarySearchPageState extends State<BinarySearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Binary Search'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                _buildItems(),
                const SizedBox(height: 32.0),
                _buildControls(context),
                const SizedBox(height: 16.0),
                _buildResult(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItems() {
    return BlocBuilder<BinarySearchBloc, BinarySearchState>(
      builder: (context, state) {
        final items = state.items;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 16.0,
            runSpacing: 16.0,
            children: items.mapIndexed(
              (index, value) {
                return Box(
                  value: '$value',
                  isCorrect: index == state.found,
                  isPotencial: index == state.potencial,
                  isSelected: index == state.left || index == state.right,
                  isError: !index.isBetween(state.left, state.right),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }

  Widget _buildControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Ingrese el valor',
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          BlocBuilder<BinarySearchBloc, BinarySearchState>(
            builder: (context, state) {
              if (state.status == BinarySearchStatus.initial) {
                return OutlinedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    final value = int.tryParse(_controller.text.trim());
                    if (value == null) {
                      return;
                    }

                    context
                        .read<BinarySearchBloc>()
                        .add(SearchItem(item: value));
                  },
                  child: const Text('Search!'),
                );
              } else {
                return OutlinedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    context.read<BinarySearchBloc>().add(const ResetItems());
                  },
                  child: const Text('Reset!'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return BlocBuilder<BinarySearchBloc, BinarySearchState>(
      builder: (context, state) {
        if (state.status == BinarySearchStatus.found) {
          return Center(child: Text('Item found at position ${state.found}'));
        }

        return const SizedBox();
      },
    );
  }
}

class Box extends StatefulWidget {
  const Box({
    Key? key,
    required this.value,
    this.isCorrect = false,
    this.isPotencial = false,
    this.isSelected = false,
    this.isError = false,
  }) : super(key: key);

  final String value;
  final bool isCorrect;
  final bool isPotencial;
  final bool isSelected;
  final bool isError;

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  Color getColor() {
    if (widget.isCorrect) {
      return Colors.green;
    } else if (widget.isError) {
      return Colors.red;
    } else if (widget.isPotencial) {
      return Colors.yellow;
    } else if (widget.isSelected) {
      return Colors.blue;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    const size = 30.0;
    final color = getColor();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: color,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      alignment: Alignment.center,
      child: Text(
        widget.value,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

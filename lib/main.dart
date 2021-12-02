import 'package:algorithm_visualizer/blocs/binary_search_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:algorithm_visualizer/blocs/binary_search_bloc.dart';
import 'package:algorithm_visualizer/pages/search/binary_search_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<BinarySearchBloc>(
            create: (context) =>
                BinarySearchBloc()..add(const InitializeItems()),
          ),
        ],
        child: const BinarySearchPage(),
      ),
    );
  }
}

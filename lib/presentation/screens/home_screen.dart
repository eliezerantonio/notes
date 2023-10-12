import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/presentation/providers/notes/notes_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final rdm = Random();

  @override
  void initState() {
    super.initState();
    ref.read(notesProvider.notifier).loadNotes();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final notesProviderAsync = ref.watch(notesProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 4,
          itemCount: notesProviderAsync.value?.$1.length ?? 10,
          itemBuilder: (BuildContext context, int index) =>
              notesProviderAsync.isLoading
                  ? FadeInUp(
                      delay: Duration(milliseconds: rdm.nextInt(1200)),
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  : const CircularProgressIndicator.adaptive(),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index.isEven ? 2 : 3),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}

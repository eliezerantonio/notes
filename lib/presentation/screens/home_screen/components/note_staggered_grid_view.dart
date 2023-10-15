import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/presentation/helpers/helpers.dart';

import '../../../providers/notes/notes_provider.dart';

class NoteStaggeredGridView extends ConsumerWidget {
  NoteStaggeredGridView({super.key});
  final _randomTime = Random();
  final _randomColor = Random();
  final List<Color> _colors = [
    const Color.fromARGB(255, 6, 157, 141),
    Colors.amber[200]!,
    Colors.blue[200]!,
    Colors.green[200]!,
    Colors.grey[350]!,
    const Color(0xff9585BA),
    const Color(0xffCBDB57),
    Colors.deepPurple[200]!,
    Colors.red[200]!
  ];
  @override
  Widget build(BuildContext context, ref) {
    final notesProviderAsync = ref.watch(notesProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: notesProviderAsync.when(
        data: (notes) {
          return StaggeredGridView.countBuilder(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 4,
            itemCount: notesProviderAsync.value?.$1?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final note = notes.$1?[index];

              return GestureDetector(
                onTap: () => context.push("/edit-note", extra: note),
                child: FadeInUp(
                  delay: Duration(milliseconds: _randomTime.nextInt(1200)),
                  child: Container(
                      height: 200,
                      width: 200,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _colors[_randomColor.nextInt(_colors.length)],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note?.title ?? "",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          10.height,
                          Text(
                            note?.description ?? "",
                            style: const TextStyle(fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          10.height,
                          Text(
                            HelperDateFormat.format(
                                note?.date ?? DateTime.now()),
                            style: TextStyle(
                                fontSize: 17, color: Colors.grey[350]!),
                          ),
                        ],
                      )),
                ),
              );
            },
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(2, index.isEven ? 2.3 : 2.5),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 10.0,
          );
        },
        error: (error, _) {
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}

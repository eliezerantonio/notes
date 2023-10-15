import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';
import '../../providers/notes/providers.dart';
import '../../providers/theme/providers.dart';
import '../search_screen/search_screen.dart';
import 'components/components.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeApp = ref.watch(themeProvider);
    final colorDarkTheme =
        themeApp.darkTheme ? const Color(0xff1c1b1f) : Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: false,
        actions: [
          Switch.adaptive(
            value: themeApp.darkTheme,
            activeColor: Colors.green,
            onChanged: (bool value) {
              ref.read(themeProvider.notifier).setTheme(value);
            },
          ),
          Card(
            child: IconButton(
              onPressed: () {
                final notesProvide = ref.read(notesProvider);

                showSearch<NoteEntity?>(
                  context: context,
                  query: '',
                  delegate: SearchDelegateScreen(
                      searchNotes: ref
                          .read(searchedMoviesProvider.notifier)
                          .searchByQuery,
                      initialNotes: notesProvide.value?.$1 ?? []),
                ).then((movie) {
                  if (movie == null) return;
                  context.push("/edit-note", extra: movie);
                });
              },
              icon: const Icon(Icons.search),
            ),
          )
        ],
      ),
      body: NoteStaggeredGridView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorDarkTheme,
        onPressed: () => context.push("/edit-note"),
        child: const Icon(Icons.add),
      ),
    );
  }
}

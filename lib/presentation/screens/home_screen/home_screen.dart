import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/domain/domain.dart';
import 'package:notes/presentation/providers/notes/notes_provider.dart';
import 'package:notes/presentation/providers/notes/search_note_provider.dart';

import '../../providers/theme/providers.dart';
import '../search_screen/search_screen.dart';
import 'components/components.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeApp = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: false,
        actions: [
          Switch.adaptive(
            value: themeApp.darkTheme,
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
        onPressed: () => context.push("/edit-note"),
        child: const Icon(Icons.add),
      ),
    );
  }
}

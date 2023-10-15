import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/domain/domain.dart';
import 'package:notes/presentation/providers/notes/notes_repository_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<NoteEntity>?>((ref) {
  final movieRepository = ref.read(notesRepositoryProvider);
  return SearchedMoviesNotifier(search: movieRepository.search, ref: ref);
});

typedef SerchMoviesCallback = Future<List<NoteEntity>?> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<NoteEntity>> {
  SearchedMoviesNotifier({required this.search, required this.ref}) : super([]);

  final SerchMoviesCallback search;
  final Ref ref;

  Future<List<NoteEntity>> searchByQuery(String query) async {
    ref.read(searchQueryProvider.notifier).update((state) => query);
    final List<NoteEntity> movies = await search(query) ?? [];

    state = movies;
    return movies;
  }
}

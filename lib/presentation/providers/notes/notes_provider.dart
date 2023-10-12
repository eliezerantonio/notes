import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/presentation/providers/notes/notes_repository_provider.dart';

import '../../../domain/domain.dart';

final notesProvider = StateNotifierProvider<NotesNotifier,
    AsyncValue<(List<NoteEntity?>, String)>>((ref) {
  final notesRepository = ref.watch(notesRepositoryProvider);
  return NotesNotifier(notesRepository);
});

class NotesNotifier
    extends StateNotifier<AsyncValue<(List<NoteEntity?>, String)>> {
  final NotesRepositories notesRepositories;

  NotesNotifier(this.notesRepositories) : super(const AsyncValue.loading());

  Future<void> loadNotes() async {
    try {
      // state = await AsyncValue.guard(() => notesRepositories.getNotes());
    } catch (e) {
      // state = AsyncValue.;
    }
  }
}

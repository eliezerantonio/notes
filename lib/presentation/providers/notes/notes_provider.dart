import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/presentation/providers/notes/notes_repository_provider.dart';

import '../../../domain/domain.dart';

final notesProvider =
    AsyncNotifierProvider<NotesNotifier, (List<NoteEntity>?, String)>(
  NotesNotifier.new,
);

class NotesNotifier extends AsyncNotifier<(List<NoteEntity>?, String)> {
  @override
  FutureOr<(List<NoteEntity>?, String)> build() async {
    return _loadNotes();
  }

  Future<(List<NoteEntity>?, String)> _loadNotes() async {
    return ref.read(notesRepositoryProvider).getNotes();
  }

  Future<String> updateNote(NoteEntity newNote) async {
    final oldState = state.asData?.value.$1 ?? [];

    final index = oldState.indexWhere((element) => element.id == newNote.id);

    final newState = <NoteEntity>[
      ...oldState.sublist(0, index),
      newNote,
      ...oldState.sublist(index + 1),
    ];
    state = const AsyncLoading();

    final response =
        await ref.read(notesRepositoryProvider).updateNote(newNote);
    state = AsyncData((newState, ""));
    return response;
  }

  Future<String> saveNote(NoteEntity note) async {
    final oldState = state.asData?.value.$1 ?? [];

    final newState = <NoteEntity>[note, ...oldState];
    state = const AsyncLoading();

    final response = await ref.read(notesRepositoryProvider).createNote(note);
    state = AsyncData((newState, ""));
    return response;
  }

  Future<String> deleteNote(String id) async {
    final oldState = state.asData?.value.$1 ?? [];

    oldState.removeWhere((element) => element.id == id);

    state = const AsyncLoading();

    final response = await ref.read(notesRepositoryProvider).deleteNoteById(id);
    state = AsyncData((oldState, ""));
    return response;
  }
}

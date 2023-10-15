import 'dart:async';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:notes/domain/entities/note_entitiy.dart';

typedef SearchNotesCallBack = Future<List<NoteEntity>?> Function(String query);

class SearchDelegateScreen extends SearchDelegate<NoteEntity?> {
  final SearchNotesCallBack searchNotes;
  List<NoteEntity> initialNotes;
  StreamController<List<NoteEntity>> debouncedNotes =
      StreamController.broadcast();

  final StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchDelegateScreen({
    required this.searchNotes,
    required this.initialNotes,
  }) : super(searchFieldLabel: 'Search notes');

  void clearStreams() {
    debouncedNotes.close();
  }

  void _onQueryChanged(String query) {
    if (query.isNotEmpty) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      isLoadingStream.add(true);
      _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
        final notes = await searchNotes(query) ?? [];

        initialNotes = notes;

        debouncedNotes.add(notes);
        isLoadingStream.add(false);
      });
    }
  }

  Widget _buildResultAndSuggestion() {
    return StreamBuilder(
      stream: debouncedNotes.stream,
      initialData: initialNotes,
      builder: (context, snapshot) {
        final notes = snapshot.data ?? [];

        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];

            return _NoteItem(
              note: note,
              onNoteSelectd: (context, note) {
                clearStreams();
                close(context, note);
              },
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder<bool>(
          initialData: false,
          stream: isLoadingStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return SpinPerfect(
                duration: const Duration(seconds: 20),
                spins: 10,
                child: IconButton(
                  onPressed: () {
                    clearStreams();
                    query = '';
                  },
                  icon: const Icon(Icons.refresh),
                ),
              );
            }

            return FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                onPressed: () {
                  clearStreams();
                  query = '';
                },
                icon: const Icon(Icons.clear),
              ),
            );
          }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultAndSuggestion();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _buildResultAndSuggestion();
  }
}

class _NoteItem extends StatelessWidget {
  const _NoteItem({required this.note, required this.onNoteSelectd});

  final NoteEntity note;
  final Function onNoteSelectd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onNoteSelectd(context, note);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          title: Text(note.title ?? ""),
          subtitle: Text(note.description ?? ""),
          leading: const Icon(Icons.notes_rounded),
        ),
      ),
    );
  }
}

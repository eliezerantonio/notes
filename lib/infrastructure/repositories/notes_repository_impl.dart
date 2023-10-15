import 'package:notes/domain/domain.dart';

class NoteRepositoryImpl implements NotesRepositories {
  final NotesDatadources _datadources;

  NoteRepositoryImpl(this._datadources);

  @override
  Future<String> createNote(NoteEntity note) async {
    return _datadources.createNote(note);
  }

  @override
  Future<String> deleteNoteById(String id) async {
    return _datadources.deleteNoteById(id);
  }

  @override
  Future<List<NoteEntity>?> search(String id) async {
    return _datadources.search(id);
  }

  @override
  Future<(List<NoteEntity>?, String)> getNotes() async {
    return _datadources.getNotes();
  }

  @override
  Future<String> updateNote(NoteEntity noteLike) async {
    return _datadources.updateNote(noteLike);
  }
}

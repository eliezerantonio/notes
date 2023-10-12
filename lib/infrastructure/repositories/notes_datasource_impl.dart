import 'package:notes/domain/domain.dart';

class NoteRepositoryImpl implements NotesRepositories {
  final NotesDatadources _datadources;

  NoteRepositoryImpl(this._datadources);

  @override
  Future<void> createNote(Map<String, dynamic> loteLike) async {
    _datadources.createNote(loteLike);
  }

  @override
  Future<void> deleteNoteById(String id) async {
    _datadources.deleteNoteById(id);
  }

  @override
  Future<(NoteEntity?, String)> getNoteById(String id) async {
    return _datadources.getNoteById(id);
  }

  @override
  Future<(List<NoteEntity>?, String)> getNotes() async {
    return _datadources.getNotes();
  }

  @override
  Future<void> updateNote(Map<String, dynamic> noteLike) async {
    updateNote(noteLike);
  }
}

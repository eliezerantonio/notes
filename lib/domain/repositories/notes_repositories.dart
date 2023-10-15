import '../entities/note_entitiy.dart';

abstract class NotesRepositories {
  Future<(List<NoteEntity>?, String)> getNotes();

  Future<List<NoteEntity>?> search(String word);

  Future<String> deleteNoteById(String id);

  Future<String> createNote(NoteEntity note);

  Future<String> updateNote(NoteEntity note);
}

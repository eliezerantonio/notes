import '../entities/note_entitiy.dart';

abstract class NotesDatadources {
  Future<(List<NoteEntity>?, String)> getNotes();

  Future<(NoteEntity?, String)> getNoteById(String id);

  Future<void> deleteNoteById(String id);

  Future<void> createNote(Map<String, dynamic> loteLike);

  Future<void> updateNote(Map<String, dynamic> noteLike);
}

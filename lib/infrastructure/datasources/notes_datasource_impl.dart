import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/domain.dart';
import '../errors/errors.dart';
import '../mappers/note_mapper.dart';

class NotesDatasourceImpl implements NotesDatadources {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionName = "notes";

  @override
  Future<String> createNote(NoteEntity note) async {
    try {
      await _firebaseFirestore
          .collection(_collectionName)
          .add(NoteMapper.entityToMap(note).toMap());
      return "Salvo com sucesso";
    } catch (e) {
      return "Erro ao salvar $e";
    }
  }

  @override
  Future<String> deleteNoteById(String id) async {
    try {
      await _firebaseFirestore.collection(_collectionName).doc(id).delete();
      return "Elimiado com sucesso";
    } catch (e) {
      return "Erro ao elimiar $e";
    }
  }

  @override
  Future<List<NoteEntity>> search(String word) async {
    try {
      List<NoteEntity> notes = [];
      final response =  await _firebaseFirestore.collection(_collectionName).get();

      final list =  response.docs.map((e) => NoteMapper.noteFirebaseToEntity(e)).toList();

      notes.addAll(list.where((element) =>    element.title!.toLowerCase().contains(word.toLowerCase())));

      return notes;
    } catch (e) {
      throw Exception(getErrorString(e.toString()));
    }
  }

  @override
  Future<(List<NoteEntity>?, String)> getNotes() async {
    try {
      final response =  await _firebaseFirestore.collection(_collectionName).get();

      return (
        response.docs.map((e) => NoteMapper.noteFirebaseToEntity(e)).toList(),
        'Notas obtidas com sucesso'
      );
    } catch (e) {
      return (null, getErrorString(e.toString()));
    }
  }

  @override
  Future<String> updateNote(NoteEntity noteLike) async {
    try {
      await _firebaseFirestore
          .collection(_collectionName)
          .doc(noteLike.id)
          .update(NoteMapper.entityToMap(noteLike).toMap());
      return "Atualizado com sucesso";
    } catch (e) {
      return "Erro ao atualizar $e";
    }
  }
}

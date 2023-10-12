import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/domain.dart';
import '../errors/errors.dart';
import '../mappers/note_mapper.dart';

class NotesDatasourceImpl implements NotesDatadources {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionName = "notes";

  @override
  Future<void> createNote(Map<String, dynamic> loteLike) async {
    // await _firebaseFirestore
    //     .collection(_collectionName)
    //     .add(beneficiary.toMap());
  }

  @override
  Future<NoteEntity> deleteNoteById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<(NoteEntity?, String)> getNoteById(String id) async {
    try {
      final response =
          await _firebaseFirestore.collection(_collectionName).doc(id).get();

      return (
        NoteMapper.noteFirebaseToEntity(response),
        'Nota obtida com sucesso'
      );
    } catch (e) {
      return (null, getErrorString(e.toString()));
    }
  }

  @override
  Future<(List<NoteEntity>?, String)> getNotes() async {
    try {
      final response =
          await _firebaseFirestore.collection(_collectionName).get();

      return (
        response.docs.map((e) => NoteMapper.noteFirebaseToEntity(e)).toList(),
        'Notas obtidas com sucesso'
      );
    } catch (e) {
      return (null, getErrorString(e.toString()));
    }
  }

  @override
  Future<void> updateNote(Map<String, dynamic> noteLike) async {}
}

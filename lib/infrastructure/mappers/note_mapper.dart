import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/infrastructure/models/note_firebase_response.dart';

import '../../domain/domain.dart';

class NoteMapper {
  static NoteEntity noteFirebaseToEntity(DocumentSnapshot snapshot) {
    final noteFirebaseResponse = NoteFirebaseResponse.fromMap(snapshot);

    return NoteEntity(
      title: noteFirebaseResponse.title,
      description: noteFirebaseResponse.description,
      date: noteFirebaseResponse.createdAt.toDate(),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes/domain/domain.dart';
import 'package:notes/infrastructure/datasources/notes_datasource_impl.dart';
import 'package:notes/infrastructure/mappers/note_mapper.dart';

import 'notes_datasource_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  QueryDocumentSnapshot,
  QuerySnapshot,
])
void main() {
  late NotesDatadources notesDatadources;
  late MockFirebaseFirestore firestore;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late String collectionName;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
 

  setUp(() {
    firestore = MockFirebaseFirestore();
    mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
    notesDatadources = NotesDatasourceImpl(firestore);
    collectionName = "notes";
    mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();

   
  });

  group("Notes Datasource", () {
    test('create Note > success', () async {
      //arrange
      final note = NoteEntity(title: "title", description: "description");

      // Mock Firestore behavior
      mockCreate(firestore, collectionName, mockCollectionReference,
          mockDocumentReference);
      //Act
      final result = await notesDatadources.createNote(note);

      verify(firestore.collection(collectionName)).called(1);

      verifyNever(
              mockCollectionReference.add(NoteMapper.entityToMap(note).toMap()))
          .called(0);
      verifyNever(mockDocumentReference.id).called(0);
      //Asset
      expect(result, "Salvo com sucesso");
    });

    test('create Note > error', () async {
      final note = NoteEntity(title: "title", description: "description");

      // Mock Firestore behavior
      mockCreate(
        firestore,
        collectionName,
        mockCollectionReference,
        mockDocumentReference,
      );

      final result = await notesDatadources.createNote(null);

      verify(firestore.collection(collectionName)).called(1);

      verifyNever(
              mockCollectionReference.add(NoteMapper.entityToMap(note).toMap()))
          .called(0);
      verifyNever(mockDocumentReference.id).called(0);
      expect(result, "Erro ao salvar");
    });

    test('Delete a note> Success', () async {
      //Arrange
      when(firestore.collection(collectionName))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);

      //act
      final result = await notesDatadources.deleteNoteById('user_id');
      //assert
      expect(result, "Elimiado com sucesso");
    });


  });
}

void mockCreate(
  MockFirebaseFirestore firestore,
  String collectionName,
  MockCollectionReference<Map<String, dynamic>> mockCollectionReference,
  MockDocumentReference<Map<String, dynamic>> mockDocumentReference,
) {
  when(firestore.collection(collectionName))
      .thenReturn(mockCollectionReference);
  when(mockCollectionReference.add(any))
      .thenAnswer((_) async => mockDocumentReference);

  when(mockDocumentReference.id).thenReturn('123');
}

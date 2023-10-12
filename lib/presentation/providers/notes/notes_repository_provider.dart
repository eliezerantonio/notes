import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/domain/domain.dart';
import 'package:notes/infrastructure/datasources/notes_datasource_impl.dart';
import 'package:notes/infrastructure/repositories/notes_datasource_impl.dart';

final notesRepositoryProvider = Provider<NotesRepositories>((ref) {
  final notesRespository = NoteRepositoryImpl(NotesDatasourceImpl());

  return notesRespository;
});

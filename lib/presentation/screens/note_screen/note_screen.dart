// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/domain/domain.dart';
import 'package:notes/presentation/helpers/helpers.dart';

import '../../providers/notes/providers.dart';
import 'components/components.dart';

class NoteScreen extends ConsumerWidget {
  final NoteEntity _noteEntity;

  NoteScreen([NoteEntity? noteEntity])
      : _noteEntity = noteEntity ?? NoteEntity();

  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, ref) {
    final noteProvier = ref.watch(notesProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          SaveOrUpdate(form: form, noteEntity: _noteEntity),
          if (_noteEntity.id != null) ...[
            DeleteNote(noteEntity: _noteEntity),
            ShareNote(noteEntity: _noteEntity)
          ],
        ],
      ),
      body: Form(
        key: form,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: _noteEntity.title ?? "",
                      style: const TextStyle(fontSize: 30),
                      decoration: const InputDecoration(
                        hintText: "Title",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 30),
                      ),
                      onSaved: (text) => _noteEntity.title = text!,
                      validator: (text) {
                        if (text!.isEmpty) return "The field is not be empty.";
                        return null;
                      },
                    ),
                    if (_noteEntity.date != null)
                      Text(HelperDateFormat.format(_noteEntity.date!),
                          style: const TextStyle(color: Colors.grey)),
                    20.height,
                    TextFormField(
                      initialValue: _noteEntity.description ?? "",
                      maxLines: 17,
                      decoration: const InputDecoration(
                        hintText: "Type something...",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 17),
                      ),
                      onSaved: (text) => _noteEntity.description = text!,
                      validator: (text) {
                        if (text!.isEmpty) return "The field is not be empty.";
                        return null;
                      },
                    )
                  ],
                ),
              ),
            ),
            if (noteProvier.isLoading)
              const Center(
                child: CircularProgressIndicator.adaptive(),
              )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/domain/domain.dart';
import 'package:notes/presentation/helpers/helpers.dart';
import 'package:notes/presentation/helpers/messeges.dart';
import 'package:notes/presentation/providers/notes/notes_provider.dart';

class NoteScreen extends ConsumerWidget {
  final NoteEntity _noteEntity;

  NoteScreen([NoteEntity? noteEntity])
      : _noteEntity = noteEntity ?? NoteEntity();

  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_noteEntity.id != null) DeleteNote(noteEntity: _noteEntity),
          20.width,
          SaveOrUpdate(form: form, noteEntity: _noteEntity),
        ],
      ),
      body: Form(
        key: form,
        child: Padding(
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
      ),
    );
  }
}

class DeleteNote extends ConsumerWidget {
  const DeleteNote({
    super.key,
    required NoteEntity noteEntity,
  }) : _noteEntity = noteEntity;

  final NoteEntity _noteEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: IconButton(
          onPressed: () {
            ref
                .read(notesProvider.notifier)
                .deleteNote(_noteEntity.id!)
                .then((message) {
              context.pop();
              showMessage(message, context);
            });
          },
          icon: const Icon(Icons.delete)),
    );
  }
}

class SaveOrUpdate extends ConsumerWidget {
  const SaveOrUpdate({
    super.key,
    required this.form,
    required this.noteEntity,
  });

  final GlobalKey<FormState> form;
  final NoteEntity? noteEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteProvier = ref.watch(notesProvider);
    return Card(
      child: noteProvier.isLoading
          ? const SizedBox(
              width: 75,
              height: 60,
              child: CircularProgressIndicator.adaptive())
          : IconButton(
              onPressed: () async {
                if (!form.currentState!.validate()) return;
                form.currentState!.save();

                if (noteEntity?.id != null) {
                  await ref
                      .read(notesProvider.notifier)
                      .updateNote(noteEntity!)
                      .then((message) => showMessage(message, context));
                  return;
                }

                await ref
                    .read(notesProvider.notifier)
                    .saveNote(noteEntity!)
                    .then((message) => showMessage(message, context));

                form.currentState!.reset();
              },
              icon: noteEntity?.id != null
                  ? const Icon(Icons.edit_square)
                  : const _SaveText(),
            ),
    );
  }
}

class _SaveText extends StatelessWidget {
  const _SaveText();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 59,
      child: Align(
        child: Text("Save"),
      ),
    );
  }
}

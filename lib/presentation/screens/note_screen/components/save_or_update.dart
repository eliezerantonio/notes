import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/domain.dart';
import '../../../helpers/helpers.dart';
import '../../../providers/notes/providers.dart';

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
      child: IconButton(
        onPressed: noteProvier.isLoading
            ? null
            : () async {
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
                    .then((message) {
                  form.currentState!.reset();
                  showMessage(message, context);
                });
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

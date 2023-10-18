import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/domain.dart';
import '../../../helpers/helpers.dart';
import '../../../providers/notes/providers.dart';

class DeleteNote extends ConsumerWidget {
  const DeleteNote({
    super.key,
    required NoteEntity noteEntity,
  }) : _noteEntity = noteEntity;

  final NoteEntity _noteEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteProvier = ref.watch(notesProvider);
    return Card(
      child: IconButton(
          onPressed: noteProvier.isLoading
              ? null
              : () {
                  ref.read(notesProvider.notifier).deleteNote(_noteEntity.id!).then((message) {
                     showMessage(message, context);
                    context.pop();
                   
                  });
                },
          icon: const Icon(Icons.delete)),
    );
  }
}

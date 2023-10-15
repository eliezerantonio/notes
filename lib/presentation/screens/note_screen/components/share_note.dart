import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../../infrastructure/shared/shared.dart';

class ShareNote extends StatelessWidget {
  const ShareNote({
    super.key,
    required NoteEntity noteEntity,
  }) : _noteEntity = noteEntity;

  final NoteEntity _noteEntity;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
      child: IconButton(
          onPressed: () {
            SharePlugin().share(_noteEntity.description!, _noteEntity.title!);
          },
          icon: const Icon(Icons.ios_share_rounded)),
    );
  }
}

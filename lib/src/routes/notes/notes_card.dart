import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/note_model.dart';
import '../../routes.dart';
import '../../utilities/constants/font_variations.dart';
import '../../utilities/constants/keys.dart';

class NotesCard extends StatelessWidget {
  final Color color;
  final NoteModel note;

  const NotesCard({
    required this.note,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      key: Keys.noteCard,
      onTap: () => Navigator.of(context).pushNamed(
        Routes.previewNote.path,
        arguments: note,
      ),
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 27,
            horizontal: 45,
          ),
          child: Text(
            note.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontVariations: [FontVariations.w400],
            ),
          ),
        ),
      ),
    );
  }
}

class NotesCardShimmer extends StatelessWidget {
  const NotesCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade300,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 27,
            horizontal: 45,
          ),
          child: SizedBox(
            height: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Divider(
                    height: 4,
                    thickness: 4,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Divider(
                    height: 4,
                    thickness: 4,
                    color: Colors.white,
                    endIndent: 50,
                  ),
                ),
                Expanded(
                  child: Divider(
                    height: 4,
                    thickness: 4,
                    color: Colors.white,
                    endIndent: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

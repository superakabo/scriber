import 'package:flutter/material.dart';
import 'package:scriber/src/utilities/constants/font_variations.dart';

import '../../utilities/constants/svgs.dart';
import '../../utilities/localizations/strings.dart';

class NoNote extends StatelessWidget {
  final String image;
  final String caption;

  const NoNote({
    required this.image,
    required this.caption,
    super.key,
  });

  factory NoNote.allNotes(Strings strings) {
    return NoNote(
      image: Images.createNote,
      caption: strings.createYourFirstNote,
    );
  }

  factory NoNote.search(Strings strings) {
    return NoNote(
      image: Images.searchAgain,
      caption: strings.noteNotFound,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
            bottom: kToolbarHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.asset(image),
              ),
              Text(
                caption,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontVariations: [FontVariations.w200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

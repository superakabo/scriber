import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/models/notes_model.dart';
import 'package:scriber/src/providers/notes_provider.dart';
import 'package:scriber/src/widgets/status_bottom_sheet.dart';

import '../../routes.dart';
import '../../utilities/constants/font_variations.dart';
import '../../utilities/localizations/strings.dart';

class PreviewNotes extends HookConsumerWidget {
  final NotesModel note;

  const PreviewNotes({
    required this.note,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = Strings.of(context)!;
    final navigator = Navigator.of(context);
    final setNotes = ref.watch(notesProvider.notifier);

    final bottomSheet = useMemoized(() => StatusBottomSheet(context: context));
    useEffect(() => bottomSheet.dispose, const []);

    void editNote() {
      navigator.pushNamed(
        Routes.createNote.path,
        arguments: note,
      );
    }

    void deleteNote() {
      final statusData = StatusData(
        title: strings.deleteNote,
        message: strings.thisActionIsIrreversible,
        status: Status.info,
        negativeButtonText: strings.cancel,
        positiveButtonText: strings.yesDeleteIt,
        onNegativeButtonPressed: bottomSheet.dismiss,
        onPositiveButtonPressed: () {
          setNotes.delete(note);
          bottomSheet.dismissPopUntil(Routes.notes.path);
        },
      );

      bottomSheet
        ..update(statusData: statusData)
        ..show();
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 68,
          leading: IconButton.filledTonal(
            splashRadius: 24,
            iconSize: 20,
            icon: const Icon(Icons.arrow_back_ios_new),
            tooltip: strings.back,
            constraints: const BoxConstraints(
              maxHeight: 48,
              maxWidth: 48,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                theme.colorScheme.onBackground.withOpacity(0.2),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: navigator.pop,
          ),
          actions: [
            ...[
              (icon: Icons.delete, tooltip: strings.delete, action: deleteNote),
              (icon: Icons.edit, tooltip: strings.edit, action: editNote),
            ].map((e) {
              return IconButton.filledTonal(
                splashRadius: 24,
                iconSize: 20,
                icon: Icon(e.icon),
                tooltip: e.tooltip,
                constraints: const BoxConstraints(
                  maxHeight: 48,
                  maxWidth: 48,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    theme.colorScheme.onBackground.withOpacity(0.2),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: e.action,
              );
            }),
            const Padding(
              padding: EdgeInsets.only(right: 10),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 18,
            ),
            children: [
              Text(
                note.title,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontVariations: [FontVariations.w800],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 34),
              ),
              Text(
                note.body,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontVariations: [FontVariations.w400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

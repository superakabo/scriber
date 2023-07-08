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
import '../../widgets/app_bar_button.dart';

class CreateNote extends HookConsumerWidget {
  final NotesModel note;

  const CreateNote({
    required this.note,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = Strings.of(context)!;
    final navigator = Navigator.of(context);
    final setNotes = ref.watch(notesProvider.notifier);
    final titleController = useTextEditingController(text: note.title);
    final bodyController = useTextEditingController(text: note.body);

    final bottomSheet = useMemoized(() => StatusBottomSheet(context: context));
    useEffect(() => bottomSheet.dispose, const []);

    /// Mark: create or update note.
    void saveNote() {
      final title = titleController.text.trim();
      final body = bodyController.text.trim();
      final createdAt = (note.id.isEmpty) ? DateTime.now().millisecondsSinceEpoch : note.createdAt;

      if (title.isEmpty || body.isEmpty) {
        final statusData = StatusData(
          title: strings.oops,
          message: (title.isEmpty) ? strings.titleCannotBeEmpty : strings.bodyCannotBeEmpty,
          status: Status.error,
          positiveButtonText: strings.ok,
          onPositiveButtonPressed: bottomSheet.dismiss,
        );

        bottomSheet
          ..update(statusData: statusData)
          ..show();
      } else {
        setNotes.save(note.copyWith(
          title: title,
          body: body,
          createdAt: createdAt,
        ));
        return navigator.popUntil(
          ModalRoute.withName(Routes.notes.path),
        );
      }
    }

    void showSaveChangesPrompt() {
      final statusData = StatusData(
        title: strings.unsavedChanges,
        message: strings.doYouWantToSaveYourChanges,
        status: Status.info,
        positiveButtonText: strings.save,
        negativeButtonText: strings.discard,
        onPositiveButtonPressed: saveNote,
        onNegativeButtonPressed: () => bottomSheet.dismissPopUntil(Routes.notes.path),
      );

      bottomSheet
        ..update(statusData: statusData)
        ..show();
    }

    bool canPop() {
      if (note.id.isEmpty) {
        final hasTitleChanges = (titleController.text.trim().isNotEmpty);
        final hasBodyChanges = (bodyController.text.trim().isNotEmpty);
        return (!hasTitleChanges && !hasBodyChanges);
      }
      final hasTitleChanges = (note.title != titleController.text.trim());
      final hasBodyChanges = (note.body != bodyController.text.trim());
      return (!hasTitleChanges && !hasBodyChanges);
    }

    void onBackPressed() {
      return (canPop()) ? navigator.pop() : showSaveChangesPrompt();
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: Colors.black,
      ),
      child: WillPopScope(
        onWillPop: () {
          onBackPressed();
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: 80,
            leading: AppBarButton(
              icon: Icons.arrow_back_ios_new,
              tooltip: strings.back,
              onPressed: onBackPressed,
            ),
            actions: [
              AppBarButton(
                icon: Icons.save,
                tooltip: strings.back,
                onPressed: saveNote,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 18),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    maxLines: null,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: strings.title,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontVariations: [FontVariations.w800],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 34),
                  ),
                  Expanded(
                    child: TextField(
                      controller: bodyController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: strings.typeSomething,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontVariations: [FontVariations.w400],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

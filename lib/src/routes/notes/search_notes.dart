import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/models/note_model.dart';
import 'package:scriber/src/providers/notes_provider.dart';

import '../../../themes.dart';
import '../../utilities/constants/keys.dart';
import '../../utilities/localizations/strings.dart';
import '../../widgets/app_bar_button.dart';
import 'no_note.dart';
import 'notes_card.dart';

class SearchNotes extends HookConsumerWidget {
  const SearchNotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    final strings = Strings.of(context)!;
    final cardColors = theme.extension<CardColors>()!.colors;

    final notesRecord = ref.watch(notesProvider);
    final filteredNotes = useValueNotifier(notesRecord.notes);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: AppBarButton(
          key: Keys.backButton,
          icon: Icons.arrow_back_ios_new,
          tooltip: strings.back,
          onPressed: navigator.pop,
        ),
        bottom: SearchBar(
          key: Keys.searchTextField,
          onSearch: (text) {
            if (text.isEmpty) {
              filteredNotes.value = notesRecord.notes;
            } else {
              filteredNotes.value = notesRecord.notes.where((e) {
                return e.title.toLowerCase().contains(text.toLowerCase().trim()) ||
                    e.body.toLowerCase().contains(text.toLowerCase().trim());
              }).toList();
            }
          },
        ),
      ),
      body: ValueListenableBuilder<List<NoteModel>>(
        valueListenable: filteredNotes,
        builder: (context, notes, __) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              if (notes.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: NoNote.search(strings),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverList.separated(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return NotesCard(
                        note: notes[index],
                        color: cardColors[index % cardColors.length],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 24),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class SearchBar extends HookConsumerWidget implements PreferredSizeWidget {
  final ValueChanged<String> onSearch;

  const SearchBar({
    required this.onSearch,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = Strings.of(context)!;
    final showClearTextButton = useValueNotifier(false);
    final controller = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
      child: TextField(
        controller: controller,
        style: theme.textTheme.bodyMedium,
        onChanged: onSearch,
        buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
          showClearTextButton.value = (isFocused && currentLength > 0) ? true : false;
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.colorScheme.onBackground.withOpacity(0.1),
          hintText: strings.searchByTheKeyword,
          constraints: const BoxConstraints(maxHeight: 34),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          suffixIconConstraints: const BoxConstraints(maxWidth: 32, maxHeight: 32),
          suffixIcon: ValueListenableBuilder<bool>(
            valueListenable: showClearTextButton,
            builder: (context, visible, __) {
              return Visibility(
                visible: visible,
                child: Material(
                  type: MaterialType.transparency,
                  clipBehavior: Clip.antiAlias,
                  shape: const CircleBorder(),
                  child: IconButton(
                    splashRadius: 28,
                    iconSize: 16,
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearch('');
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(58);
}

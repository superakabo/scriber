import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/models/notes_model.dart';
import 'package:scriber/src/providers/notes_provider.dart';
import 'package:scriber/src/utilities/constants/font_variations.dart';
import 'package:scriber/themes.dart';

import '../../routes.dart';
import '../../utilities/localizations/strings.dart';
import 'no_note.dart';
import 'notes_card.dart';

class Notes extends HookConsumerWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    final strings = Strings.of(context)!;
    final cardColors = theme.extension<CardColors>()!.colors;

    final (:notes, :loading) = ref.watch(notesProvider);
    final setNotes = ref.watch(notesProvider.notifier);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              pinned: true,
              title: Text(
                strings.notes,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontVariations: [FontVariations.w800],
                ),
              ),
              actions: [
                ...[
                  (icon: Icons.search, tooltip: strings.search, route: Routes.searchNote.path),
                  (icon: Icons.settings, tooltip: strings.settings, route: Routes.settings.path),
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
                    onPressed: () => navigator.pushNamed(e.route),
                  );
                }),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                ),
              ],
            ),
            CupertinoSliverRefreshControl(
              onRefresh: setNotes.load,
            ),
            if (notes.isEmpty && !loading)
              SliverFillRemaining(
                hasScrollBody: false,
                child: NoNote.allNotes(strings),
              )
            else if (notes.isEmpty && loading)
              SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: SliverList.builder(
                  itemCount: 10,
                  itemBuilder: (_, __) => const NotesCardShimmer(),
                ),
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
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, size: 32),
          onPressed: () => navigator.pushNamed(
            Routes.createNote.path,
            arguments: NotesModel(),
          ),
        ),
      ),
    );
  }
}

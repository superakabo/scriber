import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/models/note_model.dart';
import 'package:scriber/src/providers/notes_provider.dart';
import 'package:scriber/src/utilities/constants/font_variations.dart';
import 'package:scriber/themes.dart';

import '../../routes.dart';
import '../../utilities/constants/keys.dart';
import '../../utilities/localizations/strings.dart';
import '../../widgets/app_bar_button.dart';
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
              titleSpacing: 24,
              title: Text(
                strings.notes,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontVariations: [FontVariations.w800],
                ),
              ),
              actions: [
                ...[
                  (key: Keys.searchButton, icon: Icons.search, tooltip: strings.search, route: Routes.searchNote),
                  (key: Keys.settingsButton, icon: Icons.settings, tooltip: strings.settings, route: Routes.settings),
                ].map((e) {
                  return AppBarButton(
                    key: e.key,
                    icon: e.icon,
                    tooltip: e.tooltip,
                    onPressed: () => navigator.pushNamed(e.route.path),
                  );
                }),
                const Padding(
                  padding: EdgeInsets.only(right: 18),
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
                sliver: SliverList.separated(
                  itemCount: 10,
                  itemBuilder: (_, __) => const NotesCardShimmer(),
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 24),
                    );
                  },
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
          tooltip: strings.createNote,
          child: const Icon(Icons.add, size: 32),
          onPressed: () => navigator.pushNamed(
            Routes.createNote.path,
            arguments: NoteModel(),
          ),
        ),
      ),
    );
  }
}

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/utilities/constants/font_variations.dart';

import '../../routes.dart';
import '../../utilities/localizations/strings.dart';
import 'no_note.dart';

class Notes extends HookConsumerWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    final strings = Strings.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            strings.notes,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontVariations: [FontVariations.w800],
            ),
          ),
          actions: [
            ...[
              (icon: Icons.search, tooltip: strings.search, route: Routes.signInWithGoogle.path),
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
              padding: EdgeInsets.only(right: 12),
            ),
          ],
        ),
        body: const SafeArea(
          child: NoNote(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}

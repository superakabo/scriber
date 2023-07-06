import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/theme_mode_provider.dart';

import '../../utilities/constants/font_variations.dart';
import '../../utilities/localizations/strings.dart';

class ThemeChanger extends HookConsumerWidget {
  final VoidCallback onTap;

  const ThemeChanger({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = Strings.of(context)!;

    final themeMode = ref.watch(themeModeProvider);
    final setThemeMode = ref.watch(themeModeProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Text(
            strings.switchBetweenLightAndDark,
            style: theme.textTheme.bodySmall?.copyWith(
              fontVariations: [FontVariations.w300],
            ),
          ),
        ),
        ...[
          (title: strings.defaultTheme, icon: Icons.smartphone_outlined, mode: ThemeMode.system),
          (title: strings.lightTheme, icon: Icons.light_mode, mode: ThemeMode.light),
          (title: strings.darkTheme, icon: Icons.dark_mode_outlined, mode: ThemeMode.dark),
        ].map((e) {
          return ListTile(
            dense: true,
            leading: Icon(e.icon),
            trailing: Visibility(
              visible: (e.mode == themeMode),
              child: Icon(
                Icons.check,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ),
            title: Text(
              e.title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontVariations: [FontVariations.w500],
              ),
            ),
            onTap: () {
              setThemeMode.setThemeMode(e.mode);
              onTap();
            },
          );
        }),
      ],
    );
  }
}

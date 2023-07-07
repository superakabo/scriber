import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/locale_provider.dart';

import '../../utilities/constants/font_variations.dart';
import '../../utilities/localizations/strings.dart';

class LanguageChanger extends HookConsumerWidget {
  final VoidCallback onTap;

  const LanguageChanger({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = Strings.of(context)!;

    final locale = ref.watch(localeProvider);
    final setLocale = ref.watch(localeProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Text(
            strings.switchBetweenEnglishAndFrench,
            style: theme.textTheme.bodySmall?.copyWith(
              fontVariations: [FontVariations.w300],
            ),
          ),
        ),
        ...[
          (title: strings.english, icon: Icons.translate, code: 'en'),
          (title: strings.french, icon: Icons.translate, code: 'fr'),
        ].map((e) {
          return ListTile(
            dense: true,
            leading: Icon(e.icon),
            trailing: Visibility(
              visible: (e.code == locale.languageCode),
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
              setLocale.setThemeMode(Locale(e.code));
              onTap();
            },
          );
        }),
      ],
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scriber/src/utilities/constants/font_variations.dart';

import 'utilities/localizations/strings.dart';
import 'utilities/miscellaneous/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      supportedLocales: Strings.supportedLocales,
      localizationsDelegates: Strings.localizationsDelegates,
      onGenerateTitle: (context) => Strings.of(context)!.scriber,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'The Quick Brown Fox',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontVariations: <FontVariation>[
                  const FontVariation('wght', 200),
                ],
              ),
            ),
            Text(
              'The Quick Brown Fox',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontVariations: <FontVariation>[
                  const FontVariation('wght', 300),
                ],
              ),
            ),
            Text(
              'The Quick Brown Fox',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontVariations: <FontVariation>[
                  const FontVariation('wght', 400),
                ],
              ),
            ),
            Text(
              'The Quick Brown Fox',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontVariations: <FontVariation>[
                  const FontVariation('wght', 500),
                ],
              ),
            ),
            Text(
              'The Quick Brown Fox',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontVariations: <FontVariation>[
                  const FontVariation('wght', 600),
                ],
              ),
            ),
            Text(
              'The Quick Brown Fox',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontVariations: <FontVariation>[
                  const FontVariation('wght', 700),
                ],
              ),
            ),
            Text(
              'The Quick Brown Fox',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontVariations: <FontVariation>[
                  FontVariations.w800,
                ],
              ),
            ),
            Text(
              'The Quick Brown Fox',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontVariations: <FontVariation>[
                  FontVariations.w900,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

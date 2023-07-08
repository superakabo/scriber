import 'package:flutter/material.dart';
import 'package:scriber/src/utilities/constants/font_variations.dart';

import '../../utilities/constants/svgs.dart';
import '../../utilities/localizations/strings.dart';
import '../../widgets/app_bar_button.dart';

class AboutScriber extends StatelessWidget {
  const AboutScriber({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = Strings.of(context)!;
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: AppBarButton(
          icon: Icons.arrow_back_ios_new,
          tooltip: strings.back,
          onPressed: navigator.pop,
        ),
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(strings.scriber),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '1.0.0.1',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onBackground,
                  fontVariations: [FontVariations.w400],
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.asset(Images.logo),
                ),
              ),
            ),
          ),
          ...ListTile.divideTiles(
            context: context,
            tiles: [
              strings.designedBy('KNG Technologies - Flutter community'),
              strings.redesignedBy('Samuel Akabo'),
              strings.illustrationsBy('Lottie Animations, Storeyset'),
              strings.iconsBy('Material Design Icons'),
              strings.fontBy('Nunito - Vernon Adams, Cyreal, Jacques Le Bailly'),
              strings.madeWithFlutter('Samuel Akabo'),
            ].map(
              (e) => ListTile(
                dense: true,
                title: Text(e),
                textColor: theme.colorScheme.primary,
                titleTextStyle: theme.textTheme.bodySmall?.copyWith(
                  fontVariations: [FontVariations.w300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

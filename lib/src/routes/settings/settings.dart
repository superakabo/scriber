import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/authentication_provider.dart';
import 'package:scriber/src/providers/user_provider.dart';
import 'package:scriber/src/routes/settings/language_changer.dart';
import 'package:scriber/src/routes/settings/theme_changer.dart';

import '../../routes.dart';
import '../../utilities/constants/font_variations.dart';
import '../../utilities/constants/keys.dart';
import '../../utilities/localizations/strings.dart';
import '../../widgets/app_bar_button.dart';
import '../../widgets/status_bottom_sheet.dart';

class Settings extends HookConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = Strings.of(context)!;
    final navigator = Navigator.of(context);

    final userData = ref.watch(userProvider);
    final authProvider = ref.watch(authenticationProvider);

    final bottomSheet = useMemoized(() {
      return StatusBottomSheet(
        context: context,
        config: const SheetConfig(isDismissible: true),
      );
    });

    useEffect(() => bottomSheet.dispose, const []);

    void signOut() {
      authProvider.signOut();
      navigator.pushNamedAndRemoveUntil(
        Routes.signInWithGoogle.path,
        ModalRoute.withName('/'),
      );
    }

    void showAboutScriber() {
      navigator.pushNamed(
        Routes.aboutScriber.path,
      );
    }

    void showThemes() {
      final widget = ThemeChanger(onTap: bottomSheet.dismiss);
      bottomSheet
        ..update(widget: widget)
        ..show();
    }

    void showLanguages() {
      final widget = LanguageChanger(onTap: bottomSheet.dismiss);
      bottomSheet
        ..update(widget: widget)
        ..show();
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 80,
          leading: AppBarButton(
            key: Keys.backButton,
            icon: Icons.arrow_back_ios_new,
            tooltip: strings.back,
            onPressed: navigator.pop,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 24),
              child: Text(
                strings.settings,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontVariations: [FontVariations.w800],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 24),
                leading: CircleAvatar(
                  foregroundImage: CachedNetworkImageProvider(userData.photo),
                  backgroundColor: theme.colorScheme.onBackground.withOpacity(0.2),
                  radius: 24,
                ),
                title: Text(
                  userData.name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontVariations: [FontVariations.w600],
                  ),
                ),
                subtitle: Text(userData.emailAddress),
              ),
            ),
            const Divider(height: 0),
            ...ListTile.divideTiles(
              context: context,
              tiles: [
                (
                  key: Keys.languagesListTile,
                  title: strings.languages,
                  icon: Icons.translate,
                  action: showLanguages,
                ),
                (
                  key: Keys.themesListTile,
                  title: strings.themes,
                  icon: Icons.palette_outlined,
                  action: showThemes,
                ),
                (
                  key: Keys.aboutScriberListTile,
                  title: strings.aboutScriber,
                  icon: Icons.info_outline,
                  action: showAboutScriber
                ),
                (
                  key: Keys.signOutListTile,
                  title: strings.signOut,
                  icon: Icons.logout,
                  action: signOut,
                ),
              ].map((e) {
                return ListTile(
                  key: e.key,
                  leading: Icon(e.icon),
                  contentPadding: const EdgeInsets.only(left: 24),
                  title: Text(
                    e.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontVariations: [FontVariations.w400],
                    ),
                  ),
                  onTap: e.action,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

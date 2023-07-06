import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/authentication_provider.dart';
import 'package:scriber/src/providers/locale_provider.dart';
import 'package:scriber/src/providers/theme_mode_provider.dart';
import 'package:scriber/src/routes.dart';

import 'utilities/localizations/strings.dart';
import '../themes.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authenticationProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: Strings.supportedLocales,
      localizationsDelegates: Strings.localizationsDelegates,
      onGenerateTitle: (context) => Strings.of(context)!.scriber,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.initialRoute(authProvider.isLoggedIn),
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: themeMode,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/theme_mode_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runThemeModeProviderTests();
}

void runThemeModeProviderTests() {
  SharedPreferences.setMockInitialValues({});

  test('ThemeModeProvider.init(): should show a dark theme if there is no saved theme preference.', () {
    final container = ProviderContainer();
    final themeMode = container.read(themeModeProvider);
    expect(themeMode, ThemeMode.dark);
    addTearDown(container.dispose);
  });

  test('ThemeModeProvider.setThemeMode(): should set the theme to Light Mode.', () {
    final container = ProviderContainer();
    final themeMode = container.listen(themeModeProvider, (_, __) {});
    container.read(themeModeProvider.notifier).setThemeMode(ThemeMode.light);
    expect(themeMode.read(), ThemeMode.light);
    addTearDown(container.dispose);
  });
}

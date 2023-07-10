import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/locale_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runLocaleProviderTests();
}

void runLocaleProviderTests() {
  SharedPreferences.setMockInitialValues({});

  test('LocaleProvider.init(): should use english when there is no saved language preference.', () {
    final container = ProviderContainer();
    final locale = container.read(localeProvider);
    expect(locale.languageCode, 'en');
    addTearDown(container.dispose);
  });

  test('LocaleProvider.setLocale(): should set the language to French.', () {
    final container = ProviderContainer();
    final listener = container.listen(localeProvider, (_, __) {});
    const frenchLocale = Locale('fr');
    container.read(localeProvider.notifier).setLocale(frenchLocale);
    final currentLocale = listener.read();
    expect(currentLocale.languageCode, frenchLocale.languageCode);
    addTearDown(container.dispose);
  });
}

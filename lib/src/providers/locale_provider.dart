import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/constants/properties.dart';

final localeProvider = StateNotifierProvider.autoDispose<_StateNotifier, Locale>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final code = prefs?.getString(Properties.languageCode) ?? PlatformDispatcher.instance.locale.languageCode;
  return _StateNotifier(prefs, Locale(code));
});

class _StateNotifier extends StateNotifier<Locale> {
  _StateNotifier(this.prefs, super.state);

  final SharedPreferences? prefs;

  Future<void> setThemeMode(Locale mode) async {
    prefs?.setString(Properties.languageCode, mode.languageCode);
    if (mounted) state = mode;
  }
}

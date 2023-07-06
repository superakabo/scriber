import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/constants/properties.dart';

final themeModeProvider = StateNotifierProvider.autoDispose<_StateNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final index = prefs?.getInt(Properties.themeMode) ?? 0;
  final themeMode = ThemeMode.values.elementAt(index);
  return _StateNotifier(prefs, themeMode);
});

class _StateNotifier extends StateNotifier<ThemeMode> {
  _StateNotifier(this.prefs, super.state);

  final SharedPreferences? prefs;

  Future<void> setThemeMode(ThemeMode mode) async {
    prefs?.setInt(Properties.themeMode, mode.index);
    if (mounted) state = mode;
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/constants/properties.dart';

final themeModeProvider = StateNotifierProvider<_StateNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final index = prefs?.getInt(Properties.themeMode);
  final themeMode = (index == null) ? ThemeMode.dark : ThemeMode.values[index];
  return _StateNotifier(prefs, themeMode);
});

class _StateNotifier extends StateNotifier<ThemeMode> {
  final SharedPreferences? prefs;
  _StateNotifier(this.prefs, super.state);

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mounted) state = mode;
    prefs?.setInt(Properties.themeMode, mode.index);
  }
}

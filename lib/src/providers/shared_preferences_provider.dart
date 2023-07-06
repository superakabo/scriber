import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _sharedPreferencesProvider = FutureProvider.autoDispose<SharedPreferences?>((ref) {
  return SharedPreferences.getInstance();
});

final sharedPreferencesProvider = Provider.autoDispose<SharedPreferences?>((ref) {
  return ref.watch(_sharedPreferencesProvider).value;
});

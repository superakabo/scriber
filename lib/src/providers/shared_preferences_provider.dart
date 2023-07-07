import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _sharedPreferencesProvider = FutureProvider<SharedPreferences?>((ref) {
  return SharedPreferences.getInstance();
});

final sharedPreferencesProvider = Provider<SharedPreferences?>((ref) {
  return ref.watch(_sharedPreferencesProvider).value;
});

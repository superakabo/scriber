import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/locale_provider.dart';
import 'package:scriber/src/providers/theme_mode_provider.dart';

import 'firebase_options.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebase();
  runApp(ProviderScope(parent: _initProviders(), child: const App()));
}

/// Mark: pre-initialise settings related providers.
ProviderContainer _initProviders() {
  return ProviderContainer()
    ..read(themeModeProvider)
    ..read(localeProvider);
}

/// Mark: initialise and configure Firebase.
Future<void> _initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate();

  FlutterError.onError = (details) async {
    FlutterError.presentError(details);
    await FirebaseCrashlytics.instance.recordFlutterError(details);
  };

  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    return true;
  };
}

import 'package:flutter_test/flutter_test.dart';

import 'models/note_model_tests.dart';
import 'models/user_model_tests.dart';
import 'providers/authentication_provider_tests.dart';
import 'providers/local_provider_tests.dart';
import 'providers/notes_provider_tests.dart';
import 'providers/theme_mode_provider_tests.dart';
import 'providers/user_provider_tests.dart';

void main() {
  group('unit tests', () {
    runUserModelTests();
    runNoteModelTests();
    runAuthenticationProviderTests();
    runUserProviderTests();
    runNotesProviderTests();
    runThemeModeProviderTests();
    runLocaleProviderTests();
  });
}

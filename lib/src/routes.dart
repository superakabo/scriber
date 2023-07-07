import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:scriber/src/models/notes_model.dart';
import 'package:scriber/src/routes/authentication/sign_in_with_google.dart';

import 'routes/notes/create_note.dart';
import 'routes/notes/notes.dart';
import 'routes/notes/preview_notes.dart';
import 'routes/settings/settings.dart';

class Routes {
  static final signInWithGoogle = _RouteConfig(
    path: '/sign-in-with-google',
    fullscreen: true,
    builder: (args) => const SignInWithGoogle(),
  );

  static final notes = _RouteConfig(
    path: '/notes',
    fullscreen: true,
    builder: (args) => const Notes(),
  );

  static final createNote = _RouteConfig(
    path: '/create-note',
    fullscreen: true,
    builder: (args) => CreateNote(
      note: args as NotesModel,
    ),
  );

  static final previewNote = _RouteConfig(
    path: '/preview-note',
    builder: (args) => PreviewNotes(
      note: args as NotesModel,
    ),
  );

  static final settings = _RouteConfig(
    path: '/settings',
    builder: (args) => const Settings(),
  );

  static List<_RouteConfig> get _values {
    return [
      signInWithGoogle,
      notes,
      createNote,
      settings,
      previewNote,
    ];
  }

  static initialRoute(bool loggedIn) {
    if (loggedIn) return Routes.notes.path;
    return Routes.signInWithGoogle.path;
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    try {
      final routeModel = _values.firstWhere((e) {
        return e.path == settings.name;
      });

      if (routeModel.noTransition) {
        return CustomPageRoute(
          settings: settings,
          fullscreenDialog: routeModel.fullscreen,
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: routeModel.builder(settings.arguments),
            );
          },
        );
      }

      return CupertinoPageRoute(
        settings: settings,
        fullscreenDialog: routeModel.fullscreen,
        builder: (context) => routeModel.builder(settings.arguments),
      );
    } catch (e) {
      return null;
    }
  }
}

class _RouteConfig with EquatableMixin {
  final String path;
  final bool fullscreen;
  final bool noTransition;
  final Widget Function(Object?) builder;

  const _RouteConfig({
    required this.path,
    required this.builder,
    this.fullscreen = false,
    this.noTransition = false,
  });

  @override
  List<Object?> get props => [path, builder, fullscreen, noTransition];
}

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  CustomPageRoute({
    required super.pageBuilder,
    super.settings,
    super.transitionsBuilder = _defaultTransitionsBuilder,
    super.transitionDuration = const Duration(milliseconds: 300),
    super.barrierDismissible,
    super.barrierColor,
    super.barrierLabel,
    super.maintainState,
    super.opaque = false,
    super.fullscreenDialog = false,
  });
}

Widget _defaultTransitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return child;
}

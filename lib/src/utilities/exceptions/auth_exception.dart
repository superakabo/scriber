import 'package:firebase_auth/firebase_auth.dart';

import '../localizations/strings.dart';
import 'state_exception.dart';

class AuthException extends StateException {
  const AuthException._({
    super.title,
    super.message,
    super.code,
  });

  factory AuthException.from(FirebaseAuthException? exception, Strings strings) {
    switch (exception?.code) {
      case 'user-disabled':
        return AuthException._(
          code: exception?.code,
          title: strings.oops,
          message: strings.yourAccountHasBeenDisabled,
        );

      case 'network-request-failed':
        return AuthException._(
          code: exception?.code,
          title: strings.oops,
          message: strings.pleaseCheckYourInternet,
        );

      case 'invalid-email':
        return AuthException._(
          code: exception?.code,
          title: strings.oops,
          message: strings.pleaseCrosscheckYourEmailAddress,
        );

      case 'web-context-cancelled':
        return AuthException._(
          code: exception?.code,
          title: strings.oops,
          message: strings.verificationCancelled,
        );

      case 'web-context-canceled':
      case 'canceled':
        return AuthException._(
          code: exception?.code,
          title: strings.oops,
          message: strings.signInCancelled,
        );

      default:
        return AuthException._(
          code: exception?.code,
          title: strings.oops,
          message: exception?.message ?? '',
        );
    }
  }
}

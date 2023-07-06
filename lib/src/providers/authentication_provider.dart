import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utilities/exceptions/auth_exception.dart';
import '../utilities/localizations/strings.dart';

final authenticationProvider = Provider.autoDispose((ref) => const _Authenticator());

typedef _SignInResult = ({
  UserCredential? credential,
  AuthException? exception,
});

class _Authenticator {
  const _Authenticator();

  /// Mark: Initiate sign in with Gmail flow.
  Future<_SignInResult> signInWithGoogle(Strings strings) async {
    try {
      final oauthCredential = await _getOAuthCredential();
      final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return (credential: userCredential, exception: null);
    } //
    on FirebaseAuthException catch (exception) {
      return (
        credential: null,
        exception: AuthException.from(exception, strings),
      );
    } //
    catch (_) {
      final exception = FirebaseAuthException(code: 'canceled');
      return (
        credential: null,
        exception: AuthException.from(exception, strings),
      );
    }
  }

  /// Mark: fetch the OAuth credentials needed for
  /// Sign-in with Google.
  Future<OAuthCredential> _getOAuthCredential() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    return GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
  }

  bool get isLoggedIn {
    return (FirebaseAuth.instance.currentUser != null);
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}

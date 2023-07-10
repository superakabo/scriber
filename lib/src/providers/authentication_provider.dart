import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utilities/constants/properties.dart';

final authenticationProvider = Provider.autoDispose((ref) => _Authenticator());

typedef _SignInResult = ({
  UserCredential? credential,
  FirebaseAuthException? exception,
});

class _Authenticator {
  _Authenticator();

  @visibleForTesting
  late final fakeGoogleSignin = MockGoogleSignIn();

  @visibleForTesting
  bool get testMode {
    return const bool.fromEnvironment(Properties.testMode);
  }

  /// Mark: Initiate sign in with Gmail flow.
  Future<_SignInResult> signInWithGoogle() async {
    try {
      final oauthCredential = await getOAuthCredential();
      final userCredential = (testMode)
          ? await mockSignInWithCredential()
          : await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return (
        credential: userCredential,
        exception: null,
      );
    } on FirebaseAuthException catch (exception) {
      return (
        credential: null,
        exception: exception,
      );
    } catch (_) {
      return (
        credential: null,
        exception: FirebaseAuthException(code: 'canceled'),
      );
    }
  }

  @visibleForTesting
  MockUser get testUser {
    return MockUser(
      uid: 'QTiBNOrf66ZT1criSgambZcsA5w3',
      email: 'johdoe@example.com',
      displayName: 'John Doe',
      photoURL: 'https://randomuser.me/api/portraits/men/16.jpg',
      metadata: UserMetadata(1689000330000, 1689000330000),
    );
  }

  @visibleForTesting
  Future<UserCredential> mockSignInWithCredential() async {
    final credential = await getOAuthCredential();
    final auth = MockFirebaseAuth(mockUser: testUser);
    return await auth.signInWithCredential(credential);
  }

  /// Mark: fetch the OAuth credentials needed for
  /// Sign-in with Google.
  Future<OAuthCredential> getOAuthCredential() async {
    final googleSignIn = (testMode) ? fakeGoogleSignin : GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
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
    return (testMode)
        ? await MockFirebaseAuth(mockUser: testUser, signedIn: true).signOut()
        : await FirebaseAuth.instance.signOut();
  }
}

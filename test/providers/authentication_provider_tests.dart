import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/authentication_provider.dart';

void main() {
  runAuthenticationProviderTests();
}

void runAuthenticationProviderTests() {
  final container = ProviderContainer();
  final provider = container.read(authenticationProvider);

  test('AuthenticationProvider.getCredential(): should return idToken and accessToken.', () async {
    final credential = await provider.getOAuthCredential();
    expect(credential.accessToken, isNotNull);
    expect(credential.idToken, isNotNull);
  });

  test('AuthenticationProvider.signInWithGoogle(): should return valid user id.', () async {
    final record = await provider.signInWithGoogle();
    expect(record.credential?.user?.uid, isNotNull);
    expect(record.credential?.user?.email, isNotNull);
    expect(record.credential?.user?.displayName, isNotNull);
  });

  test('AuthenticationProvider.signInWithGoogleCancelled(): should return null when login is cancelled.', () async {
    provider.fakeGoogleSignin.setIsCancelled(true);
    final signInAccount = await provider.fakeGoogleSignin.signIn();
    expect(signInAccount, isNull);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/models/user_model.dart';
import 'package:scriber/src/providers/user_provider.dart';
import 'package:scriber/src/utilities/constants/properties.dart';

void main() {
  runUserProviderTests();
}

void runUserProviderTests() {
  final userData = UserModel.fromMap({
    Properties.id: 'z3Qr4XWipnnklMGKzLhj',
    Properties.name: 'John Doe',
    Properties.photo: 'https://randomuser.me/api/portraits/men/88.jpg',
    Properties.emailAddress: 'johndoe@example.com',
    Properties.createdAt: 1688825760000,
  });

  test('UserProvider.documentRef(): should create a Firestore document reference that matches the supplied id.', () {
    final container = ProviderContainer();
    final provider = container.read(userProviderTest.notifier);
    final docRef = provider.documentRef(userData.id);
    expect(docRef.id, userData.id);
  });

  test('UserProvider.save(): should save the user data to Firestore and retrieve it.', () {
    final container = ProviderContainer();
    final savedData = container.listen(userProviderTest, (_, __) {});
    container.read(userProviderTest.notifier)
      ..save(userData)
      ..get(userData.id);
    expect(userData, savedData.read());
  });
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scriber/src/models/user_model.dart';
import 'package:scriber/src/utilities/constants/properties.dart';

void main() {
  runUserModelTests();
}

void runUserModelTests() {
  final testData = {
    Properties.id: 'z3Qr4XWipnnklMGKzLhj',
    Properties.name: 'John Doe',
    Properties.photo: 'https://randomuser.me/api/portraits/men/88.jpg',
    Properties.emailAddress: 'johndoe@example.com',
    Properties.createdAt: 1688825760000,
  };

  final userData = UserModel.fromMap(testData);

  test('UserModel.fromMap(): should convert JSON to a valid instance of UserModel.', () {
    expect(userData.id, 'z3Qr4XWipnnklMGKzLhj');
    expect(userData.name, 'John Doe');
    expect(userData.photo, 'https://randomuser.me/api/portraits/men/88.jpg');
    expect(userData.emailAddress, 'johndoe@example.com');
    expect(userData.createdAt, 1688825760000);
  });

  test('UserModel.copyWith(): should create a new instance of UserModel with copied or updated values.', () {
    final update = userData.copyWith(
      id: 'vMtCrrFePKN5x94ifxNj',
      name: 'Jane Doe',
      photo: 'https://randomuser.me/api/portraits/women/88.jpg',
      emailAddress: 'janedoe@example.com',
      createdAt: 5,
    );

    expect(update.id, 'vMtCrrFePKN5x94ifxNj');
    expect(update.name, 'Jane Doe');
    expect(update.photo, 'https://randomuser.me/api/portraits/women/88.jpg');
    expect(update.emailAddress, 'janedoe@example.com');
    expect(update.createdAt, 5);
    expect(update.hashCode, isNot(userData.hashCode), reason: 'A new object should have a different hash code.');
  });

  test('UserModel.fromUser(): should create a new instance of UserModel from a Firebase user.', () {
    final user = MockUser(
      isAnonymous: false,
      uid: 'vMtCrrFePKN5x94ifxNj',
      email: 'johndoe@example.com',
      displayName: 'johndoe',
      photoURL: 'https://randomuser.me/api/portraits/men/88.jpg',
      metadata: UserMetadata(6, 3),
    );

    final newUserData = UserModel.fromUser(user);

    expect(newUserData.id, user.uid);
    expect(newUserData.name, user.displayName);
    expect(newUserData.photo, user.photoURL);
    expect(newUserData.emailAddress, user.email);
    expect(newUserData.createdAt, user.metadata.creationTime?.millisecondsSinceEpoch);
  });

  test('UserModel.toMap(): should convert an instance of UserModel to JSON.', () {
    expect(userData.toMap(), testData);
  });

  test('UserModel.props: should check the number of properties within UserModel.', () {
    expect(userData.props.length, testData.length);
    expect(userData.toMap().length, testData.length);
  });
}

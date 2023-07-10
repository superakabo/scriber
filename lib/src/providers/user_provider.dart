import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/user_model.dart';
import '../utilities/constants/collections.dart';
import '../utilities/constants/properties.dart';

final userProvider = StateNotifierProvider.autoDispose<_StateNotifer, UserModel>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  return _StateNotifer(UserModel.fromUser(user));
});

@visibleForTesting
final userProviderTest = StateNotifierProvider.autoDispose<_StateNotifer, UserModel>((ref) {
  final user = MockUser(
    isAnonymous: false,
    uid: 'vMtCrrFePKN5x94ifxNj',
    email: 'johndoe@example.com',
    displayName: 'johndoe',
    photoURL: 'https://randomuser.me/api/portraits/men/88.jpg',
    metadata: UserMetadata(1688825760000, 1688825760000),
  );
  return _StateNotifer(UserModel.fromUser(user));
});

class _StateNotifer extends StateNotifier<UserModel> {
  _StateNotifer(super._state);

  @visibleForTesting
  late final fakeFirestore = FakeFirebaseFirestore();

  @visibleForTesting
  bool get testMode {
    return const bool.fromEnvironment(Properties.testMode);
  }

  /// Mark: generate a firestore document reference
  /// to query or save user data.
  DocumentReference<UserModel> documentRef(
    String id,
  ) {
    final firestore = (testMode) ? fakeFirestore : FirebaseFirestore.instance;
    final collectionReference = firestore.collection(Collections.users);
    final documentReference = collectionReference.doc(id);

    return documentReference.withConverter<UserModel>(
      fromFirestore: (snapshot, options) => UserModel.fromMap(snapshot.data()),
      toFirestore: (userData, options) => userData.toMap(),
    );
  }

  /// Mark: save user data to firestore.
  Future<void> save(UserModel userData) async {
    try {
      if (mounted) state = userData;
      final ref = documentRef(userData.id);
      return await ref.set(userData, SetOptions(merge: true));
    } catch (e, s) {
      return FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// Mark: load user data from firestore.
  Future<void> get(String id) async {
    final snapshot = await documentRef(id).get();
    if (snapshot.exists) {
      if (mounted) state = snapshot.data()!;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/user_model.dart';
import '../utilities/constants/collections.dart';

final userProvider = StateNotifierProvider.autoDispose<_StateNotifer, UserModel>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  return _StateNotifer(UserModel.fromUser(user));
});

class _StateNotifer extends StateNotifier<UserModel> {
  _StateNotifer(super._state);

  /// Mark: generate a firestore document reference
  /// to query or save user data.
  DocumentReference<UserModel> _documentRef(String id) {
    final collectionReference = FirebaseFirestore.instance.collection(Collections.users);
    final documentReference = collectionReference.doc(id);

    return documentReference.withConverter<UserModel>(
      fromFirestore: (snapshot, options) => UserModel.fromMap(snapshot.data()),
      toFirestore: (userData, options) => userData.toMap(),
    );
  }

  /// Mark: save user data to firestore.
  Future<void> save(UserModel userData) async {
    try {
      await _documentRef(userData.id).set(userData, SetOptions(merge: true));
      if (mounted) state = userData;
    } catch (e, s) {
      return FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}

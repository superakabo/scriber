import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/user_provider.dart';

import '../models/note_model.dart';
import '../utilities/constants/collections.dart';
import '../utilities/constants/properties.dart';

final notesProvider = StateNotifierProvider.autoDispose<_StateNotifier, NotesResult>((ref) {
  final userData = ref.watch(userProvider);
  return _StateNotifier(userData.id)..load();
});

@visibleForTesting
final notesProviderTest = StateNotifierProvider.autoDispose<_StateNotifier, NotesResult>((ref) {
  return _StateNotifier('6g4ZakFRVX8VQPxU0SDyPj1DRo2zqNypuTniNRf1')..load();
});

typedef NotesResult = ({
  List<NoteModel> notes,
  bool loading,
});

class _StateNotifier extends StateNotifier<NotesResult> {
  _StateNotifier(this._userId) : super((notes: [], loading: false));

  final String _userId;

  @visibleForTesting
  late final fakeFirestore = FakeFirebaseFirestore();

  @visibleForTesting
  bool get testMode {
    return const bool.fromEnvironment(Properties.testMode);
  }

  /// Mark: build collection reference that converts JSON to Notes model instance.
  CollectionReference<NoteModel> collectionRef() {
    final firestore = (testMode) ? fakeFirestore : FirebaseFirestore.instance;
    return firestore.collection(Collections.notes).withConverter<NoteModel>(
          fromFirestore: (snapshot, options) => NoteModel.fromMap(snapshot.data()),
          toFirestore: (note, options) => note.toMap(),
        );
  }

  /// Mark: build query for fetching all notes for the current user.
  Query<NoteModel> _query() {
    return collectionRef().where(Properties.userId, isEqualTo: _userId).orderBy(Properties.createdAt, descending: true);
  }

  /// Mark: fetch all notes for the current user.
  Future<void> load() async {
    try {
      if (_userId.trim().isEmpty) return;
      if (state.notes.isNotEmpty && state.loading && !testMode) return;

      if (mounted) state = (notes: state.notes, loading: true);

      final snapshot = await _query().get();
      final notes = snapshot.docs.map((e) => e.data()).toList();

      if (mounted) state = (notes: notes, loading: false);
    } //
    on FirebaseException catch (e) {
      if (e.code == 'unavailable') return load();
    } //
    catch (exception, stackTrace) {
      if (mounted) state = (notes: state.notes, loading: false);
      return FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    }
  }

  /// Mark: insert or update notes locally.
  void _updateNotesLocally(NoteModel note) {
    final index = state.notes.indexWhere((e) => e.id == note.id);
    if (index == -1) {
      if (mounted) state = (notes: [note, ...state.notes], loading: false);
    } else {
      state.notes[index] = note;
      if (mounted) state = (notes: List.of(state.notes), loading: false);
    }
  }

  /// Mark: save note to Firestore.
  Future<void> save(NoteModel note) async {
    final docRef = collectionRef().doc(note.id.trim().isEmpty ? null : note.id);
    final newState = note.copyWith(id: docRef.id, userId: _userId);
    _updateNotesLocally(newState);
    return await docRef.set(newState, SetOptions(merge: true));
  }

  /// Mark: Delete saved note from Firestore
  /// and remove it locally too.
  Future<void> delete(NoteModel note) async {
    final newState = state.notes.where((e) => e.id != note.id).toList();
    if (mounted) state = (notes: newState, loading: false);
    return await collectionRef().doc(note.id).delete();
  }
}

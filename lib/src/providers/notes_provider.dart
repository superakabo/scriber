import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/providers/user_provider.dart';

import '../models/notes_model.dart';
import '../utilities/constants/collections.dart';
import '../utilities/constants/properties.dart';

final notesProvider = StateNotifierProvider.autoDispose<_StateNotifier, NotesResult>((ref) {
  final userData = ref.watch(userProvider);
  return _StateNotifier(userData.id)..load();
});

typedef NotesResult = ({
  List<NotesModel> notes,
  bool loading,
});

class _StateNotifier extends StateNotifier<NotesResult> {
  _StateNotifier(this._userId) : super((notes: [], loading: false));

  final String _userId;

  /// Mark: build collection reference that converts JSON to Notes model instance.
  CollectionReference<NotesModel> get _collectionRef {
    return FirebaseFirestore.instance.collection(Collections.notes).withConverter<NotesModel>(
          fromFirestore: (snapshot, options) => NotesModel.fromMap(snapshot.data()),
          toFirestore: (note, options) => note.toMap(),
        );
  }

  /// Mark: build query for fetching all notes for the current user.
  Query<NotesModel> get _query {
    return _collectionRef.where(Properties.userId, isEqualTo: _userId).orderBy(Properties.createdAt, descending: true);
  }

  /// Mark: fetch all notes for the current user.
  Future<void> load() async {
    try {
      if (_userId.trim().isEmpty) return;
      if (state.notes.isNotEmpty && state.loading) return;

      if (mounted) state = (notes: state.notes, loading: true);

      final snapshot = await _query.get();
      final notes = snapshot.docs.map((e) => e.data()).toList();

      if (mounted) state = (notes: notes, loading: false);
    } //
    catch (exception, stackTrace) {
      if (mounted) state = (notes: state.notes, loading: false);
      return FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    }
  }

  /// Mark: insert or update notes locally.
  void updateNotesLocally(NotesModel note) {
    final index = state.notes.indexWhere((e) => e.id == note.id);
    if (index == -1) {
      if (mounted) state = (notes: [note, ...state.notes], loading: false);
    } else {
      state.notes[index] = note;
      if (mounted) state = (notes: List.of(state.notes), loading: false);
    }
  }

  /// Mark: save note to Firestore.
  Future<void> save(NotesModel note) async {
    final docRef = _collectionRef.doc(note.id.trim().isEmpty ? null : note.id);
    final newState = note.copyWith(id: docRef.id, userId: _userId);
    updateNotesLocally(newState);
    return await docRef.set(newState, SetOptions(merge: true));
  }

  /// Mark: Delete saved note from Firestore
  /// and remove it locally too.
  Future<void> delete(NotesModel note) async {
    final newState = state.notes.where((e) => e.id != note.id).toList();
    if (mounted) state = (notes: newState, loading: false);
    return await _collectionRef.doc(note.id).delete();
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scriber/src/models/note_model.dart';
import 'package:scriber/src/providers/notes_provider.dart';

void main() {
  runNotesProviderTests();
}

void runNotesProviderTests() {
  final container = ProviderContainer();
  final listner = container.listen(notesProviderTest, (_, __) {});
  final provider = container.read(notesProviderTest.notifier);

  test('NotesProvider.save(): should save a new note to Firestore and update list locally.', () {
    const noteData = NoteModel.raw(
      userId: '',
      id: '',
      title: 'The man who never left',
      body: 'This is a long body for the man...',
      createdAt: 500,
    );

    provider.save(noteData);
    final savedNote = listner.read().notes.first;

    expect(noteData.id, isNot(savedNote.id));
    expect(noteData.userId, isNot(savedNote.id));
    expect(noteData.title, savedNote.title);
    expect(noteData.body, savedNote.body);
    expect(noteData.createdAt, savedNote.createdAt);
  });

  test('NotesProvider.load(): should fetch all notes from Firestore.', () {
    provider.load();
    final notes = listner.read().notes;
    expect(1, notes.length, reason: 'The count of notes has increased from 0 to 1.');
  });

  test('NotesProvider.delete(): should delete a note from Firestore.', () {
    final savedNote = listner.read().notes.first;
    provider.delete(savedNote);
    final notes = listner.read().notes;
    expect(0, notes.length, reason: 'The count of notes has decreased from 1 to 0.');
  });
}

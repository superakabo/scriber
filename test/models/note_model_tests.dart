import 'package:flutter_test/flutter_test.dart';
import 'package:scriber/src/models/note_model.dart';
import 'package:scriber/src/utilities/constants/properties.dart';

void main() {
  runNoteModelTests();
}

void runNoteModelTests() {
  final testData = {
    Properties.id: 'z3Qr4XWipnnklMGKzLhj',
    Properties.userId: 'Vp88JfpQrVp88JfpQrXAWwyZkrUSdXAWwyZkrUSd',
    Properties.title: 'The quick brown fox',
    Properties.body: 'jumps over the lazy dog.',
    Properties.createdAt: 1688825760000,
  };

  final noteData = NoteModel.fromMap(testData);

  test('NoteModel.fromMap(): should convert JSON to a valid instance of NoteModel.', () {
    expect(noteData.id, 'z3Qr4XWipnnklMGKzLhj');
    expect(noteData.userId, 'Vp88JfpQrVp88JfpQrXAWwyZkrUSdXAWwyZkrUSd');
    expect(noteData.title, 'The quick brown fox');
    expect(noteData.body, 'jumps over the lazy dog.');
    expect(noteData.createdAt, 1688825760000);
  });

  test('NoteModel.copyWith(): should create a new instance of NoteModel with copied or updated values.', () {
    final update = noteData.copyWith(
      id: 'Q3Qr4XWipnnkyuGKzLhB',
      userId: 'Dp88JfpIrVp88JfpQrXAWwyZkrUSdXAWwyZkrZuc',
      title: 'The slow black fox',
      body: 'out run the lazy cat.',
      createdAt: 3,
    );

    expect(update.id, 'Q3Qr4XWipnnkyuGKzLhB');
    expect(update.userId, 'Dp88JfpIrVp88JfpQrXAWwyZkrUSdXAWwyZkrZuc');
    expect(update.title, 'The slow black fox');
    expect(update.body, 'out run the lazy cat.');
    expect(update.createdAt, 3);
    expect(update.hashCode, isNot(noteData.hashCode), reason: 'A new object should have a different hash code.');
  });

  test('NoteModel.toMap(): should convert an of NoteModel to JSON.', () {
    expect(testData, noteData.toMap());
  });

  test('NoteModel.props: should check the number of properties within NoteModel.', () {
    expect(noteData.props.length, testData.length);
    expect(noteData.toMap().length, testData.length);
  });
}

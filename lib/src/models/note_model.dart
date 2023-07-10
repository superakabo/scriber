import 'package:equatable/equatable.dart';

import '../utilities/constants/properties.dart';

class NoteModel with EquatableMixin {
  /// Mark: the unique note identifier.
  final String id;

  /// Mark: the title of the note.
  final String title;

  /// Mark: the content of the note.
  final String body;

  /// Mark: the identifier of the user that created the note.
  final String userId;

  /// Mark: the note creation date in timestamp (milliseconds).
  final int createdAt;

  const NoteModel.raw({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.createdAt,
  });

  factory NoteModel() => NoteModel.fromMap(null);

  factory NoteModel.fromMap(Map<String, dynamic>? data) {
    return NoteModel.raw(
      id: data?[Properties.id] ?? '',
      title: data?[Properties.title] ?? '',
      body: data?[Properties.body] ?? '',
      userId: data?[Properties.userId] ?? '',
      createdAt: data?[Properties.createdAt] ?? 0,
    );
  }

  NoteModel copyWith({
    String? id,
    String? title,
    String? body,
    String? userId,
    int? createdAt,
  }) {
    return NoteModel.raw(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Properties.id: id,
      Properties.title: title,
      Properties.body: body,
      Properties.userId: userId,
      Properties.createdAt: createdAt,
    };
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, title, body, userId, createdAt];
}

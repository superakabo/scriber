import 'package:equatable/equatable.dart';

import '../utilities/constants/properties.dart';

class NotesModel with EquatableMixin {
  final String id;
  final String title;
  final String body;
  final String userId;
  final int createdAt;

  const NotesModel.raw({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.createdAt,
  });

  factory NotesModel() => NotesModel.fromMap(null);

  factory NotesModel.fromMap(Map<String, dynamic>? data) {
    return NotesModel.raw(
      id: data?[Properties.id] ?? '',
      title: data?[Properties.title] ?? '',
      body: data?[Properties.body] ?? '',
      userId: data?[Properties.userId] ?? '',
      createdAt: data?[Properties.createdAt] ?? 0,
    );
  }

  NotesModel copyWith({
    String? id,
    String? title,
    String? body,
    String? userId,
    int? createdAt,
  }) {
    return NotesModel.raw(
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

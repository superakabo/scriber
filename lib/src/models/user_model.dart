import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scriber/src/utilities/constants/properties.dart';

class UserModel with EquatableMixin {
  final String id;
  final String name;
  final String photo;
  final String emailAddress;
  final int createdAt;

  const UserModel.raw({
    required this.id,
    required this.name,
    required this.photo,
    required this.emailAddress,
    required this.createdAt,
  });

  factory UserModel() => UserModel.fromMap(null);

  factory UserModel.fromMap(Map<String, dynamic>? data) {
    return UserModel.raw(
      id: data?[Properties.id] ?? '',
      name: data?[Properties.name] ?? '',
      photo: data?[Properties.photo] ?? '',
      emailAddress: data?[Properties.emailAddress] ?? '',
      createdAt: data?[Properties.createdAt] ?? 0,
    );
  }

  factory UserModel.fromUser(User? user) {
    return UserModel().copyWith(
      id: user?.uid,
      emailAddress: user?.email,
      name: user?.displayName,
      photo: user?.photoURL,
      createdAt: user?.metadata.creationTime?.millisecondsSinceEpoch,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? photo,
    String? emailAddress,
    int? createdAt,
  }) {
    return UserModel.raw(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      emailAddress: emailAddress ?? this.emailAddress,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Properties.id: id,
      Properties.name: name,
      Properties.photo: photo,
      Properties.emailAddress: emailAddress,
      Properties.createdAt: createdAt,
    };
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, name, photo, emailAddress, createdAt];
}

import 'package:equatable/equatable.dart';

class StateException extends Equatable implements Exception {
  final String title;
  final String message;
  final String? code;

  const StateException({
    this.title = '',
    this.message = '',
    this.code,
  });

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [title, message, code];
}

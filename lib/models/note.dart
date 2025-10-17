import 'dart:convert';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String body;

  const Note({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'body': body,
  };

  @override
  List<Object?> get props => [id, title, body];
}

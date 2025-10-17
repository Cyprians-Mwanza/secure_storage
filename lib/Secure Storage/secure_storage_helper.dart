import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/note.dart';

class SecureStorageHelper {
  static const _notesKey = 'secure_notes';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<Note>> getNotes() async {
    final jsonString = await _storage.read(key: _notesKey);
    if (jsonString == null) return [];
    final List data = json.decode(jsonString);
    return data.map((e) => Note.fromMap(e)).toList();
  }

  Future<void> saveNotes(List<Note> notes) async {
    final encoded = json.encode(notes.map((n) => n.toMap()).toList());
    await _storage.write(key: _notesKey, value: encoded);
  }

  Future<void> addNote(Note note) async {
    final notes = await getNotes();
    notes.insert(0, note);
    await saveNotes(notes);
  }

  Future<void> updateNote(Note updatedNote) async {
    final notes = await getNotes();
    final index = notes.indexWhere((n) => n.id == updatedNote.id);
    if (index != -1) {
      notes[index] = updatedNote;
      await saveNotes(notes);
    }
  }

  Future<void> deleteNoteById(String id) async {
    final notes = await getNotes();
    notes.removeWhere((n) => n.id == id);
    await saveNotes(notes);
  }

  Future<void> clearAll() async => _storage.delete(key: _notesKey);
}

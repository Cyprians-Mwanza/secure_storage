import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/note.dart';
import '../../services/local/secure_storage_helper.dart';
import 'note_state.dart';
import 'package:uuid/uuid.dart';

class NoteCubit extends Cubit<NoteState> {
  final SecureStorageHelper _secureHelper = SecureStorageHelper();
  final _uuid = const Uuid();

  NoteCubit() : super(NoteInitial());

  Future<void> fetchAllNotes() async {
    emit(NoteLoading());
    try {
      final notes = await _secureHelper.getNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError('Failed to fetch notes: $e'));
    }
  }

  Future<void> addNote(Note note) async {
    try {
      final newNote = note.copyWith(id: _uuid.v4());
      await _secureHelper.addNote(newNote);
      emit(NoteActionSuccess('Note added securely.'));
      fetchAllNotes();
    } catch (e) {
      emit(NoteError('Failed to add note: $e'));
    }
  }

  Future<void> updateNoteById(Note note) async {
    try {
      await _secureHelper.updateNote(note);
      emit(NoteActionSuccess('Note updated securely.'));
      fetchAllNotes();
    } catch (e) {
      emit(NoteError('Failed to update note: $e'));
    }
  }

  Future<void> deleteNoteById(String id) async {
    try {
      await _secureHelper.deleteNoteById(id);
      emit(NoteActionSuccess('Note deleted securely.'));
      fetchAllNotes();
    } catch (e) {
      emit(NoteError('Failed to delete note: $e'));
    }
  }
}

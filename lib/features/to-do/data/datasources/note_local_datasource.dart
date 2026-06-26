import 'package:app_starter_kit_bloc/core/storage/hive/schema.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

abstract interface class NoteLocalDatasource {
  Future<List<Note>> getNotes();
  Future<Note?> getNote(String id);
  Future<void> saveNote(Note note);
  Future<void> deleteNote(String id);
}

@Injectable(as: NoteLocalDatasource)
class NoteLocalDatasourceImpl implements NoteLocalDatasource {
  final Box<Note> _notesBox;

  NoteLocalDatasourceImpl({required Box<Note> notesBox}) : _notesBox = notesBox;

  @override
  Future<List<Note>> getNotes() async {
    return _notesBox.values.toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  @override
  Future<Note?> getNote(String id) async {
    return _notesBox.get(id);
  }

  @override
  Future<void> saveNote(Note note) async {
    await _notesBox.put(note.id, note);
  }

  @override
  Future<void> deleteNote(String id) async {
    await _notesBox.delete(id);
  }
}
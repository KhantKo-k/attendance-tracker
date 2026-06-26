part of 'notes_bloc.dart';

@freezed
abstract class NotesEvent with _$NotesEvent {
  const factory NotesEvent.fetchNotes() = _FetchNotes;

  const factory NotesEvent.refresh() = _Refresh;

  const factory NotesEvent.deleteNote(String id) = _DeleteNote;
}

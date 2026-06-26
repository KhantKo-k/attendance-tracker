part of 'note_form_bloc.dart';

@freezed
abstract class NoteFormEvent with _$NoteFormEvent {
  const factory NoteFormEvent.loadNote(String noteId) = _LoadNote;

  const factory NoteFormEvent.newNote() = _NewNote;

  const factory NoteFormEvent.titleChanged(String title) = _TitleChanged;

  const factory NoteFormEvent.contentChanged(String content) = _ContentChanged;

  /// Persists immediately (e.g. before leaving the screen).
  const factory NoteFormEvent.saveRequested() = _SaveRequested;

  const factory NoteFormEvent.saveFailureHandled() = _SaveFailureHandled;
}

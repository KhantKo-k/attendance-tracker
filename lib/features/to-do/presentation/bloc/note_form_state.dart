part of 'note_form_bloc.dart';

@freezed
abstract class NoteFormState with _$NoteFormState {
  const factory NoteFormState.initial() = _NoteFormInitial;

  const factory NoteFormState.loading() = _NoteFormLoading;

  const factory NoteFormState.editing({
    required NoteEntity note,
    @Default(false) bool isSaving,
    @Default(false) bool isDirty,
    Failure? saveFailure,
  }) = _NoteFormEditing;

  const factory NoteFormState.failure(Failure failure) = _NoteFormFailure;
}

extension NoteFormStateX on NoteFormState {
  bool get isLoading => maybeMap(loading: (_) => true, orElse: () => false);

  bool get isSaving =>
      maybeMap(editing: (s) => s.isSaving, orElse: () => false);

  bool get isDirty => maybeMap(editing: (s) => s.isDirty, orElse: () => false);

  Failure? get saveFailure =>
      maybeMap(editing: (s) => s.saveFailure, orElse: () => null);

  String get title =>
      maybeMap(editing: (s) => s.note.title, orElse: () => '');

  String get content =>
      maybeMap(editing: (s) => s.note.content, orElse: () => '');

  bool get canEdit => maybeMap(editing: (_) => true, orElse: () => false);
}

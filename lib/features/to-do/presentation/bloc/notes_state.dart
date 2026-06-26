part of 'notes_bloc.dart';

@freezed
abstract class NotesState with _$NotesState {
  const factory NotesState({
    @Default([]) List<NoteEntity> notes,
    @Default(false) bool isLoading,
    @Default(false) bool isDeleting,
    Failure? failure,
  }) = _NotesState;
}

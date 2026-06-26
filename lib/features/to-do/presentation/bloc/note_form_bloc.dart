import 'dart:async';

import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/entities/note_entity.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/usecases/get_note_use_case.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/usecases/new_note_use_case.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/usecases/save_note_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';
part 'note_form_bloc.freezed.dart';

@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  NoteFormBloc({
    required GetNoteUseCase getNoteUseCase,
    required NewNoteUseCase newNoteUseCase,
    required SaveNoteUseCase saveNoteUseCase,
  }) : _getNoteUseCase = getNoteUseCase,
       _newNoteUseCase = newNoteUseCase,
       _saveNoteUseCase = saveNoteUseCase,
       super(const NoteFormState.initial()) {
    on<_LoadNote>(_onLoadNote);
    on<_NewNote>(_onNewNote);
    on<_TitleChanged>(_onTitleChanged);
    on<_ContentChanged>(_onContentChanged);
    on<_SaveRequested>(_onSaveRequested);
    on<_SaveFailureHandled>(_onSaveFailureHandled);
  }

  static const _autoSaveDebounce = Duration(milliseconds: 600);

  final GetNoteUseCase _getNoteUseCase;
  final NewNoteUseCase _newNoteUseCase;
  final SaveNoteUseCase _saveNoteUseCase;

  Timer? _autoSaveTimer;

  @override
  Future<void> close() {
    _autoSaveTimer?.cancel();
    return super.close();
  }

  Future<void> _onLoadNote(_LoadNote event, Emitter<NoteFormState> emit) async {
    emit(const NoteFormState.loading());
    final result = await _getNoteUseCase(event.noteId);
    result.fold(
      (note) => emit(NoteFormState.editing(note: note)),
      (failure) => emit(NoteFormState.failure(failure)),
    );
  }

  Future<void> _onNewNote(_NewNote event, Emitter<NoteFormState> emit) async {
    emit(const NoteFormState.loading());

    final result = await _newNoteUseCase();
    result.fold(
      (note) => emit(NoteFormState.editing(note: note)),
      (failure) => emit(NoteFormState.failure(failure)),
    );
  }

  void _onTitleChanged(_TitleChanged event, Emitter<NoteFormState> emit) {
    _updateNote(
      emit,
      (note) => note.copyWith(title: event.title),
    );
  }

  void _onContentChanged(_ContentChanged event, Emitter<NoteFormState> emit) {
    _updateNote(
      emit,
      (note) => note.copyWith(content: event.content),
    );
  }

  void _updateNote(
    Emitter<NoteFormState> emit,
    NoteEntity Function(NoteEntity note) update,
  ) {
    final current = state;
    if (current is! _NoteFormEditing) return;

    final updated = update(current.note);
    if (updated == current.note) return;

    emit(
      current.copyWith(
        note: updated,
        isDirty: true,
        saveFailure: null,
      ),
    );
    _scheduleAutoSave();
  }

  void _scheduleAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer(_autoSaveDebounce, () {
      add(const NoteFormEvent.saveRequested());
    });
  }

  Future<void> _onSaveRequested(
    _SaveRequested event,
    Emitter<NoteFormState> emit,
  ) async {
    _autoSaveTimer?.cancel();
    await _persistCurrentNote(emit);
  }

  void _onSaveFailureHandled(
    _SaveFailureHandled event,
    Emitter<NoteFormState> emit,
  ) {
    final current = state;
    if (current is! _NoteFormEditing) return;
    emit(current.copyWith(saveFailure: null));
  }

  Future<void> _persistCurrentNote(Emitter<NoteFormState> emit) async {
    final current = state;
    if (current is! _NoteFormEditing) return;
    if (!current.isDirty || current.isSaving) return;

    emit(current.copyWith(isSaving: true, saveFailure: null));

    final result = await _saveNoteUseCase(current.note);

    final latest = state;
    if (latest is! _NoteFormEditing) return;

    result.fold(
      (savedNote) {
        final stillEditing = state;
        if (stillEditing is! _NoteFormEditing) return;

        final noteChangedWhileSaving = stillEditing.note != current.note;
        emit(
          stillEditing.copyWith(
            note: noteChangedWhileSaving ? stillEditing.note : savedNote,
            isSaving: false,
            isDirty: noteChangedWhileSaving,
            saveFailure: null,
          ),
        );

        if (noteChangedWhileSaving) {
          _scheduleAutoSave();
        }
      },
      (failure) {
        final stillEditing = state;
        if (stillEditing is! _NoteFormEditing) return;
        emit(
          stillEditing.copyWith(
            isSaving: false,
            saveFailure: failure,
          ),
        );
      },
    );
  }
}

import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/entities/note_entity.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/usecases/delete_note_use_case.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/usecases/get_notes_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notes_event.dart';
part 'notes_state.dart';
part 'notes_bloc.freezed.dart';

@injectable
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc({
    required GetNotesUseCase getNotesUseCase,
    required DeleteNoteUseCase deleteNoteUseCase,
  }) : _getNotesUseCase = getNotesUseCase,
       _deleteNoteUseCase = deleteNoteUseCase,
       super(const NotesState()) {
    on<_FetchNotes>(_onFetchNotes);
    on<_Refresh>(_onRefresh);
    on<_DeleteNote>(_onDeleteNote);
  }

  final GetNotesUseCase _getNotesUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  Future<void> _onFetchNotes(
    _FetchNotes event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _getNotesUseCase();

    result.fold(
      (notes) => emit(
        state.copyWith(notes: notes, isLoading: false, failure: null),
      ),
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
    );
  }

  Future<void> _onRefresh(_Refresh event, Emitter<NotesState> emit) async {
    if (state.isLoading) return;
    add(const NotesEvent.fetchNotes());
  }

  Future<void> _onDeleteNote(
    _DeleteNote event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(isDeleting: true, failure: null));

    final result = await _deleteNoteUseCase(event.id);

    result.fold(
      (_) {
        final updated = state.notes
            .where((note) => note.id != event.id)
            .toList();
        emit(
          state.copyWith(
            notes: updated,
            isDeleting: false,
            failure: null,
          ),
        );
      },
      (failure) =>
          emit(state.copyWith(isDeleting: false, failure: failure)),
    );
  }
}

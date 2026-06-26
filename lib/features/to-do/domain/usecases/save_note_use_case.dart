import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/entities/note_entity.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveNoteUseCase {
  final NoteRepository _noteRepository;

  SaveNoteUseCase({required NoteRepository noteRepository})
    : _noteRepository = noteRepository;

  Future<Either<NoteEntity, Failure>> call(NoteEntity note) async {
    return _noteRepository.saveNote(note.copyWith(updatedAt: DateTime.now()));
  }
}
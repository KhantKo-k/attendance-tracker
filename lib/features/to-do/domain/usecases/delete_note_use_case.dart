import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteNoteUseCase {
  final NoteRepository _noteRepository;

  DeleteNoteUseCase({required NoteRepository noteRepository})
    : _noteRepository = noteRepository;

  Future<Either<void, Failure>> call(String id) {
    return _noteRepository.deleteNote(id);
  }
}

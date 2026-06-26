import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/entities/note_entity.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotesUseCase {
  final NoteRepository _noteRepository;

  GetNotesUseCase({required NoteRepository noteRepository}) : _noteRepository = noteRepository;

    Future<Either<List<NoteEntity>, Failure>> call() async {
    final result = await _noteRepository.getNotes();
    return result;
  }
}
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/entities/note_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class NoteRepository {
  Future<Either<List<NoteEntity>, Failure>> getNotes();

  Future<Either<NoteEntity, Failure>> getNote(String id);

  Future<Either<NoteEntity, Failure>> newNote();

  Future<Either<NoteEntity, Failure>> saveNote(NoteEntity note);

  Future<Either<void, Failure>> deleteNote(String id);
}

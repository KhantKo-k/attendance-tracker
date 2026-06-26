import 'package:app_starter_kit_bloc/core/error/error_handler_guard.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/to-do/data/datasources/note_local_datasource.dart';
import 'package:app_starter_kit_bloc/features/to-do/data/mappers/note_model_mapper.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/entities/note_entity.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NoteRepository)
class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl({required NoteLocalDatasource noteLocalDatasource})
    : _noteLocalDatasource = noteLocalDatasource;

  final NoteLocalDatasource _noteLocalDatasource;

  @override
  Future<Either<List<NoteEntity>, Failure>> getNotes() {
    return ErrorHandlerGuard.on<List<NoteEntity>>(() async {
      final notes = await _noteLocalDatasource.getNotes();
      return notes.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<NoteEntity, Failure>> getNote(String id) {
    return ErrorHandlerGuard.on<NoteEntity>(() async {
      final note = await _noteLocalDatasource.getNote(id);
      if (note == null) {
        throw FormatException('Note not found: $id');
      }
      return note.toEntity();
    });
  }

  @override
  Future<Either<NoteEntity, Failure>> newNote() async {
    return ErrorHandlerGuard.on<NoteEntity>(() async {
      final note = NoteEntity.draft();
      final model = NoteModelMapper.fromEntity(note);
      await _noteLocalDatasource.saveNote(model);
      return note;
    });
  }

  @override
  Future<Either<NoteEntity, Failure>> saveNote(NoteEntity note) {
    return ErrorHandlerGuard.on<NoteEntity>(() async {
      final model = NoteModelMapper.fromEntity(note);
      await _noteLocalDatasource.saveNote(model);
      return model.toEntity();
    });
  }

  @override
  Future<Either<void, Failure>> deleteNote(String id) {
    return ErrorHandlerGuard.on<void>(() async {
      final existing = await _noteLocalDatasource.getNote(id);
      if (existing == null) {
        throw FormatException('Note not found: $id');
      }
      await _noteLocalDatasource.deleteNote(id);
    });
  }
}

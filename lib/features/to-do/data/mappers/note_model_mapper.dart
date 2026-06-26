import 'package:app_starter_kit_bloc/core/storage/hive/schema.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/entities/note_entity.dart';

extension NoteModelMapper on Note {
  static Note fromEntity(NoteEntity entity) => Note(
    id: entity.id,
    title: entity.title,
    content: entity.content,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
  );

  NoteEntity toEntity() => NoteEntity(
    id: id,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

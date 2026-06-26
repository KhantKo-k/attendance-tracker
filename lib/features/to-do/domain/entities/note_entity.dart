import 'package:app_starter_kit_bloc/shared/utils/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_entity.freezed.dart';

@freezed
abstract class NoteEntity with _$NoteEntity {
  const factory NoteEntity({
    required String id,
    required String title,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NoteEntity;

  factory NoteEntity.draft() => NoteEntity(
    id: uuid.v4(),
    title: '',
    content: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}

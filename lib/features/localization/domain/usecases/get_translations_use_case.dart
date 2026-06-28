import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/localization/domain/repository/localization_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTranslationUsecase {
  final LocalizationRepository repository;
  const GetTranslationUsecase(this.repository);

  
   Future<Either<Map<String, dynamic>, Failure>> call({
    required String path,
    required String langCode,
    void Function()? onUpdate,
  }) async {
    return await repository.getTranslations(path: path, langCode: langCode, onUpdate: onUpdate);
  }
}
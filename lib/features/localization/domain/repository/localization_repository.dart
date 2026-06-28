import 'package:attendance_tracker/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class LocalizationRepository {
   Future<Either<Map<String, dynamic>, Failure>> getTranslations({
    required String path,
    required String langCode,
    void Function()? onUpdate,
  });
}
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/experiment/domain/entities/mock_model.dart';
import 'package:dartz/dartz.dart';

abstract class MockRepository {
  Future<Either<MockModel, Failure>> request();
}
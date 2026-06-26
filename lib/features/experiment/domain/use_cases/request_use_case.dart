import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/experiment/domain/entities/mock_model.dart';
import 'package:app_starter_kit_bloc/features/experiment/domain/repositories/mock_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable 
class RequestUseCase {
  final MockRepository _mockRepository;

  RequestUseCase({
    required MockRepository mockRepository,
  }) : _mockRepository = mockRepository;

  Future<Either<MockModel, Failure>> call() async {
    final result = await _mockRepository.request();
    return result;
  }
}
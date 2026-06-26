import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/experiment/data/data_sources.dart/mock_api.dart';
import 'package:app_starter_kit_bloc/features/experiment/domain/entities/mock_model.dart';
import 'package:app_starter_kit_bloc/features/experiment/domain/repositories/mock_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MockRepository)
class MockRepositoryImpl implements MockRepository {
  final MockApiInterface _mockApi;

  MockRepositoryImpl({required MockApiInterface mockApi}) : _mockApi = mockApi;

  @override
  Future<Either<MockModel, Failure>> request() async {
    final response = await _mockApi.request();

    return response.fold(
      (mockResponse) => Left(MockModel.fromMockResponse(mockResponse)),
      (failure) => Right(failure),
    );
  }
}

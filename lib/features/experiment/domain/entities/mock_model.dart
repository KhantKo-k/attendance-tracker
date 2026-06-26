
import 'package:app_starter_kit_bloc/features/experiment/data/dtos/mock_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mock_model.freezed.dart';
part 'mock_model.g.dart';

@freezed 
abstract class MockModel with _$MockModel {
  const factory MockModel({
    required int id,
    required String username,
    required String email, 
  }) = _MockModel;

  factory MockModel.fromJson(Map<String, dynamic> json) => _$MockModelFromJson(json);

  factory MockModel.fromMockResponse(MockResponse mockResponse) => MockModel( 
    id: mockResponse.id,
    username: mockResponse.username,
    email: mockResponse.email,
  );
}
import 'package:json_annotation/json_annotation.dart';

part 'mock_response.g.dart';

@JsonSerializable()
class MockResponse {
  final int id;
  final String username;
  final String email;


  MockResponse({
    required this.id,
    required this.username,
    required this.email,
  });

  factory MockResponse.fromJson(Map<String, dynamic> json) =>
      _$MockResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MockResponseToJson(this);
}

MockResponse deserializeMockResponse(Map<String, dynamic> json) => MockResponse.fromJson(json);

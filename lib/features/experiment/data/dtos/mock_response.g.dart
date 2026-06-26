// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MockResponse _$MockResponseFromJson(Map<String, dynamic> json) => MockResponse(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$MockResponseToJson(MockResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
    };

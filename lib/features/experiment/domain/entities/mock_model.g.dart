// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MockModel _$MockModelFromJson(Map<String, dynamic> json) => _MockModel(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$MockModelToJson(_MockModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
    };

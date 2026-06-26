import 'package:freezed_annotation/freezed_annotation.dart';

part 'localization_dtos.freezed.dart';
part 'localization_dtos.g.dart';

@freezed
abstract class LocalizationDto with _$LocalizationDto {
  const factory LocalizationDto({required Map<String, dynamic> data}) =
      _LocalizationDto;

  factory LocalizationDto.fromJson(Map<String, dynamic> json) =>
      _$LocalizationDtoFromJson({'data': json});
}

LocalizationDto deserializeLocalizationDto(Map<String, dynamic> json) =>
    LocalizationDto.fromJson(json);
import 'package:app_starter_kit_bloc/core/network/api_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_dtos.freezed.dart';
part 'product_dtos.g.dart';

@freezed
abstract class ProductDto with _$ProductDto {
  const factory ProductDto({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,

    List<String>? tags,
    String? brand,
    String? sku,

    ProductDimensionDto? dimensions,

    String? warrantyInformation,
    String? shippingInformation,

    String? availabilityStatus,

    List<ProductReviewDto>? reviews,

    String? returnPolicy,
    int? minimumOrderQuantity,

    Map<String, dynamic>? meta,

    String? thumbnail,

    List<String>? images,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);
}

@freezed
abstract class ProductReviewDto with _$ProductReviewDto {
  const factory ProductReviewDto({
    int? rating,
    String? comment,
    String? date,
    String? reviewerName,
    String? reviewerEmail,
  }) = _ProductReviewDto;

  factory ProductReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewDtoFromJson(json);
}

@freezed
abstract class ProductDimensionDto with _$ProductDimensionDto {
  const factory ProductDimensionDto({
    double? width,
    double? height,
    double? depth,
  }) = _ProductDimensionDto;

  factory ProductDimensionDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDimensionDtoFromJson(json);
}

@freezed
abstract class ProductListDto with _$ProductListDto {
  const factory ProductListDto({
    List<ProductDto>? products,
    int? total,
    int? skip,
    int? limit,
  }) = _ProductListDto;

  factory ProductListDto.fromJson(Map<String, dynamic> json) =>
      _$ProductListDtoFromJson(json);
}

@freezed
abstract class NewProductDto with _$NewProductDto {
  const factory NewProductDto({
    required String title,
    required String description,
    required String category,
    @Default(0.0) double price,
    @Default(0.0) double discountPercentage,
    required List<String> tags,
    required String brand,
    required String sku,
    required ProductDimensionDto? dimensions,
    required String? warrantyInformation,
    required String? shippingInformation,
    required String? availabilityStatus,
    required String? returnPolicy,
    required int minimumOrderQuantity,
    Map<String, dynamic>? meta,
    required String thumbnail,
    required List<String> images,
  }) = _NewProductDto;

  factory NewProductDto.fromJson(Map<String, dynamic> json) =>
      _$NewProductDtoFromJson(json);
}

ProductListDto deserializeProductListDto(Map<String, dynamic> json) =>
    ProductListDto.fromJson(json);

ProductDto deserializeProductDto(Map<String, dynamic> json) =>
    ProductDto.fromJson(json);

ApiResponse<ProductListDto> deserializeApiResponseProductListDto(
  Map<String, dynamic> json,
) => ApiResponse<ProductListDto>.fromJson(
  json,
  (json) => ProductListDto.fromJson(json as Map<String, dynamic>),
);

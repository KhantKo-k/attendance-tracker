import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
abstract class Product with _$Product {
  const Product._(); // required for custom getters/methods

  const factory Product({
    int? id, // null = not persisted yet
    @Default('') String title,
    @Default('') String description,
    @Default('') String category,
    @Default(0.0) double price,
    @Default(0.0) double discountPercentage,
    @Default(0.0) double rating,
    @Default(0) int stock,
    @Default([]) List<String> tags,
    @Default('') String brand,
    @Default('') String sku,
    ProductDimension? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    @Default('') String availabilityStatus,
    @Default([]) List<ProductReview> reviews,
    String? returnPolicy,
    @Default(0) int minimumOrderQuantity,
    Map<String, dynamic>? meta,
    @Default('') String thumbnail,
    @Default([]) List<String> images,
  }) = _Product;

  /// Blank product for "Add product" / form initial state.
  factory Product.draft() => const Product();

  bool get isNew => id == null;
}

@freezed
abstract class ProductReview with _$ProductReview {
  const factory ProductReview({
    required int rating,
    required String comment,
    required String date,
    required String reviewerName,
    required String reviewerEmail,
  }) = _ProductReview;
}

@freezed
abstract class ProductDimension with _$ProductDimension {
  const factory ProductDimension({
    required double width,
    required double height,
    required double depth,
  }) = _ProductDimension;
}

@freezed
abstract class ProductList with _$ProductList {
  const factory ProductList({
    required List<Product> products,
    required int total,
    required int skip,
    required int limit,
  }) = _ProductList;
}

import 'package:app_starter_kit_bloc/features/product/data/dtos/product_dtos.dart';
import 'package:app_starter_kit_bloc/features/product/domain/entities/product.dart';

extension ProductListDtoMapper on ProductListDto {
  ProductList toDomain() => ProductList(
    products: (products ?? []).map((e) => e.toDomain()).toList(),
    total: total ?? 0,
    skip: skip ?? 0,
    limit: limit ?? 0,
  );
}

extension ProductDtoMapper on ProductDto {
  Product toDomain() => Product(
    id: id ?? 0,
    title: title ?? '',
    description: description ?? '',
    category: category ?? '',
    price: price ?? 0,
    discountPercentage: discountPercentage ?? 0,
    rating: rating ?? 0,
    stock: stock ?? 0,
    tags: tags ?? [],
    brand: brand ?? '',
    sku: sku ?? '',
    dimensions: (dimensions ?? const ProductDimensionDto()).toDomain(),
    warrantyInformation: warrantyInformation,
    shippingInformation: shippingInformation,
    availabilityStatus: availabilityStatus ?? '',
    reviews: (reviews ?? []).map((e) => e.toDomain()).toList(),
    returnPolicy: returnPolicy,
    minimumOrderQuantity: minimumOrderQuantity ?? 0,
    meta: meta ?? {},
    thumbnail: thumbnail ?? '',
    images: images ?? [],
  );

  static ProductDto fromDomain(Product product) => ProductDto(
    id: product.id,
    title: product.title,
    description: product.description,
    category: product.category,
    price: product.price,
    discountPercentage: product.discountPercentage,
    rating: product.rating,
    stock: product.stock,
    tags: product.tags,
    brand: product.brand,
    sku: product.sku,
    dimensions: ProductDimensionDtoMapper.fromDomain(product.dimensions!),
    warrantyInformation: product.warrantyInformation,
    shippingInformation: product.shippingInformation,
    availabilityStatus: product.availabilityStatus,
    returnPolicy: product.returnPolicy,
    minimumOrderQuantity: product.minimumOrderQuantity,
    meta: product.meta,
  );
}

extension ProductReviewDtoMapper on ProductReviewDto {
  ProductReview toDomain() => ProductReview(
    rating: rating ?? 0,
    comment: comment ?? '',
    date: date ?? '',
    reviewerName: reviewerName ?? '',
    reviewerEmail: reviewerEmail ?? '',
  );
}

extension ProductDimensionDtoMapper on ProductDimensionDto {
  ProductDimension toDomain() => ProductDimension(
    width: width ?? 0,
    height: height ?? 0,
    depth: depth ?? 0,
  );

  static ProductDimensionDto fromDomain(ProductDimension dimension) =>
      ProductDimensionDto(
        width: dimension.width,
        height: dimension.height,
        depth: dimension.depth,
      );
}

extension NewProductDtoMapper on NewProductDto {
  static NewProductDto fromDomain(Product product) => NewProductDto(
    title: product.title,
    description: product.description,
    category: product.category,
    price: product.price,
    discountPercentage: product.discountPercentage,
    tags: product.tags,
    brand: product.brand,
    sku: product.sku,
    dimensions: product.dimensions == null
        ? null
        : ProductDimensionDtoMapper.fromDomain(product.dimensions!),
    warrantyInformation: product.warrantyInformation,
    shippingInformation: product.shippingInformation,
    availabilityStatus: product.availabilityStatus,
    returnPolicy: product.returnPolicy,
    minimumOrderQuantity: product.minimumOrderQuantity,
    meta: product.meta,
    thumbnail: product.thumbnail,
    images: product.images,
  );
}

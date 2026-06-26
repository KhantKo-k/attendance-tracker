import 'package:app_starter_kit_bloc/core/constants/enums/order_by.dart';
import 'package:app_starter_kit_bloc/core/error/error_handler_guard.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/product/data/data_sources/product_api.dart';
import 'package:app_starter_kit_bloc/features/product/data/dtos/product_dtos.dart';
import 'package:app_starter_kit_bloc/features/product/data/mappers/product_dto_mapper.dart';
import 'package:app_starter_kit_bloc/features/product/domain/entities/product.dart';
import 'package:app_starter_kit_bloc/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductApi productApi;

  ProductRepositoryImpl({required this.productApi});

  @override
  Future<Either<Product, Failure>> getProduct(String id) async {
    final result = await productApi.getProductDetail(id);

    return result.guardedParse<Product, ProductDto>((left) => left.toDomain());
  }

  @override
  Future<Either<ProductList, Failure>> getProducts({
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) async {
    final result = await productApi.getProducts(
      skip: skip,
      limit: limit,
      sortBy: sortBy,
      orderBy: orderBy,
    );

    return result.guardedParse<ProductList, ProductListDto>(
      (left) => left.toDomain(),
    );
  }

  @override
  Future<Either<ProductList, Failure>> searchProducts(
    String query, {
    int skip = 0,
    int limit = 0,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) async {
    final result = await productApi.searchProducts(
      query,
      skip: skip,
      limit: limit,
      sortBy: sortBy,
      orderBy: orderBy,
    );

    return result.guardedParse<ProductList, ProductListDto>(
      (left) => left.toDomain(),
    );
  }

  @override
  Future<Either<Product, Failure>> addProduct(Product product) async {
    final result = await productApi.addProduct(
      NewProductDtoMapper.fromDomain(product),
    );

    return result.guardedParse<Product, ProductDto>((left) => left.toDomain());
  }

  @override
  Future<Either<Product, Failure>> updateProduct(Product product) async {
    final result = await productApi.updateProduct(
      ProductDtoMapper.fromDomain(product),
    );

    return result.guardedParse<Product, ProductDto>((left) => left.toDomain());
  }

  @override
  Future<Either<Product, Failure>> deleteProduct(String id) async {
    final result = await productApi.deleteProduct(id);

    return result.guardedParse<Product, ProductDto>((left) => left.toDomain());
  }
}

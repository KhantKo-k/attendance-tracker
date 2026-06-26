import 'package:app_starter_kit_bloc/core/constants/enums/order_by.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/product/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

enum ProductSortBy {
  title,
  price;

  @override
  String toString() => name;
}

String? serializeProductSortBy(ProductSortBy? sortBy) => sortBy?.toString();

abstract class ProductRepository {
  Future<Either<ProductList, Failure>> getProducts({
    int skip = 0,
    int limit = 0,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  });

  Future<Either<ProductList, Failure>> searchProducts(
    String query, {
    int skip = 0,
    int limit = 0,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  });

  Future<Either<Product, Failure>> getProduct(String id);

  Future<Either<Product, Failure>> addProduct(Product product);

  Future<Either<Product, Failure>> updateProduct(Product product);

  Future<Either<Product, Failure>> deleteProduct(String id);
}

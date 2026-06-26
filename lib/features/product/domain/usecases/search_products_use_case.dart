
import 'package:app_starter_kit_bloc/core/constants/enums/order_by.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/product/domain/entities/product.dart';
import 'package:app_starter_kit_bloc/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable 
class SearchProductsUseCase {
  final ProductRepository _productRepository;

  SearchProductsUseCase({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  Future<Either<ProductList, Failure>> call( {
    required String query,
    int skip = 0,
    int limit = 0,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) async {
    final result = await _productRepository.searchProducts(query, skip: skip, limit: limit, sortBy: sortBy, orderBy: orderBy);
    return result;
  }
}
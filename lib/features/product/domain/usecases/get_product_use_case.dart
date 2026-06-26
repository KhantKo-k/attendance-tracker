

import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/product/domain/entities/product.dart';
import 'package:app_starter_kit_bloc/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductUseCase {
  final ProductRepository _productRepository;

  GetProductUseCase({required ProductRepository productRepository}) : _productRepository = productRepository;

  Future<Either<Product, Failure>> call(String id) async {
    final result = await _productRepository.getProduct(id);
    return result;
  }
}
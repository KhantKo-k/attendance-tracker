import 'package:app_starter_kit_bloc/core/constants/basic_query_param_constants.dart';
import 'package:app_starter_kit_bloc/core/di/environments.dart';
import 'package:app_starter_kit_bloc/core/constants/enums/order_by.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/core/network/api_response.dart';
import 'package:app_starter_kit_bloc/core/network/dio_module.dart';
import 'package:app_starter_kit_bloc/core/network/retrofit_api_call_adapter.dart';
import 'package:app_starter_kit_bloc/features/product/data/dtos/product_dtos.dart';
import 'package:app_starter_kit_bloc/features/product/domain/repositories/product_repository.dart';
import 'package:app_starter_kit_bloc/features/product/product_urls.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'product_api.g.dart';

abstract interface class ProductApi {
  Future<Either<ProductListDto, Failure>> getProducts({
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  });
  Future<Either<ProductListDto, Failure>> searchProducts(
    String quer, {
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  });
  Future<Either<ProductDto, Failure>> getProductDetail(String id);

  Future<Either<ProductDto, Failure>> addProduct(NewProductDto product);

  Future<Either<ProductDto, Failure>> updateProduct(ProductDto product);

  Future<Either<ProductDto, Failure>> deleteProduct(String id);
}

abstract interface class ProductApiV2 {
  Future<Either<ApiResponse<ProductListDto>, Failure>> getProducts({
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  });
}

@prodEnv
@devEnv
@uatEnv
@preprodEnv
@Injectable(as: ProductApi)
@RestApi(parser: Parser.FlutterCompute, callAdapter: RetrofitApiCallAdapter)
abstract class ProductApiImpl implements ProductApi {
  @factoryMethod
  factory ProductApiImpl(@Named(privateApiClientKey) Dio dio) = _ProductApiImpl;

  @override
  @GET(ProductUrls.productApi)
  Future<Either<ProductListDto, Failure>> getProducts({
    @Query(BasicQueryParamConstants.skip) int? skip,
    @Query(BasicQueryParamConstants.limit) int? limit,
    @Query(BasicQueryParamConstants.sortBy) ProductSortBy? sortBy,
    @Query(BasicQueryParamConstants.orderBy) OrderBy? orderBy,
  });

  @override
  @GET(ProductUrls.productSearch)
  Future<Either<ProductListDto, Failure>> searchProducts(
    @Query('q') String query, {
    @Query(BasicQueryParamConstants.skip) int? skip,
    @Query(BasicQueryParamConstants.limit) int? limit,
    @Query(BasicQueryParamConstants.sortBy) ProductSortBy? sortBy,
    @Query(BasicQueryParamConstants.orderBy) OrderBy? orderBy,
  });

  @override
  @GET(ProductUrls.productById)
  Future<Either<ProductDto, Failure>> getProductDetail(@Path('id') String id);

  @override
  @POST(ProductUrls.productApi)
  Future<Either<ProductDto, Failure>> addProduct(NewProductDto product);

  @override
  @PUT(ProductUrls.productApi)
  Future<Either<ProductDto, Failure>> updateProduct(ProductDto product);

  @override
  @DELETE(ProductUrls.productApi)
  Future<Either<ProductDto, Failure>> deleteProduct(String id);
}

@prodEnv
@devEnv
@uatEnv
@preprodEnv
@Injectable(as: ProductApiV2)
@RestApi(parser: Parser.FlutterCompute, callAdapter: RetrofitApiCallAdapter)
abstract class ProductApiV2Impl implements ProductApiV2 {
  @factoryMethod
  factory ProductApiV2Impl(@Named(privateApiClientKey) Dio dio) =
      _ProductApiV2Impl;

  @override
  @GET(ProductUrls.productApi)
  Future<Either<ApiResponse<ProductListDto>, Failure>> getProducts({
    @Query(BasicQueryParamConstants.skip) int? skip,
    @Query(BasicQueryParamConstants.limit) int? limit,
    @Query(BasicQueryParamConstants.sortBy) ProductSortBy? sortBy,
    @Query(BasicQueryParamConstants.orderBy) OrderBy? orderBy,
  });
}

@mockEnv
@Injectable(as: ProductApi)
class MockProductApiImpl implements ProductApi {
  @override
  Future<Either<ProductListDto, Failure>> getProducts({
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) {
    return Future.value(Left(ProductListDto(products: [], total: 0)));
  }

  @override
  Future<Either<ProductDto, Failure>> getProductDetail(String id) {
    // TODO: implement getProductDetail
    throw UnimplementedError();
  }

  @override
  Future<Either<ProductListDto, Failure>> searchProducts(
    String quer, {
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) {
    // TODO: implement searchProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<ProductDto, Failure>> addProduct(NewProductDto product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<ProductDto, Failure>> updateProduct(ProductDto product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<ProductDto, Failure>> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
}

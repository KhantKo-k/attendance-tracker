import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

/// Response model for APIs which has standard format.
/// This will be initialized by parsing the `data` field of the response.
///
/// Response json example:
/// ```json
/// {
///   "status": 200,
///   "message": "Success",
///   "data": {
///     "id": 1,
///     "name": "John Doe"
///   }
/// }
/// ```
///
/// Response class example:
///
/// ```dart
/// @override
/// @GET(ProductUrls.productApi)
/// Future<Either<ApiResponse<ProductListDto>, Failure>> getProducts({
///   @Query(BasicQueryParamConstants.skip) int? skip,
///   @Query(BasicQueryParamConstants.limit) int? limit,
///   @Query(BasicQueryParamConstants.sortBy) ProductSortBy? sortBy,
///   @Query(BasicQueryParamConstants.orderBy) OrderBy? orderBy,
/// });
/// ```
@Freezed(genericArgumentFactories: true)
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required int status,
    required String message,
    T? data,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}

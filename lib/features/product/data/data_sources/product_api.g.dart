// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main,avoid_redundant_argument_values

class _ProductApiImpl implements ProductApiImpl {
  _ProductApiImpl(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  Future<ProductListDto> _getProducts({
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'skip': skip,
      r'limit': limit,
      r'sortBy': await compute(serializeProductSortBy, sortBy),
      r'orderBy': await compute(serializeOrderBy, orderBy),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<Either<ProductListDto, Failure>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/products',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ProductListDto _value;
    try {
      _value = await compute(deserializeProductListDto, _result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Either<ProductListDto, Failure>> getProducts({
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) {
    return RetrofitApiCallAdapter<ProductListDto>().adapt(
      () => _getProducts(
        skip: skip,
        limit: limit,
        sortBy: sortBy,
        orderBy: orderBy,
      ),
    );
  }

  Future<ProductListDto> _searchProducts(
    String query, {
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'q': query,
      r'skip': skip,
      r'limit': limit,
      r'sortBy': await compute(serializeProductSortBy, sortBy),
      r'orderBy': await compute(serializeOrderBy, orderBy),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<Either<ProductListDto, Failure>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/products/search',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ProductListDto _value;
    try {
      _value = await compute(deserializeProductListDto, _result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Either<ProductListDto, Failure>> searchProducts(
    String query, {
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) {
    return RetrofitApiCallAdapter<ProductListDto>().adapt(
      () => _searchProducts(
        query,
        skip: skip,
        limit: limit,
        sortBy: sortBy,
        orderBy: orderBy,
      ),
    );
  }

  Future<ProductDto> _getProductDetail(String id) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<Either<ProductDto, Failure>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/products/${id}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ProductDto _value;
    try {
      _value = await compute(deserializeProductDto, _result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Either<ProductDto, Failure>> getProductDetail(String id) {
    return RetrofitApiCallAdapter<ProductDto>().adapt(
      () => _getProductDetail(id),
    );
  }

  Future<ProductDto> _addProduct(NewProductDto product) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<Either<ProductDto, Failure>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/products',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ProductDto _value;
    try {
      _value = await compute(deserializeProductDto, _result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Either<ProductDto, Failure>> addProduct(NewProductDto product) {
    return RetrofitApiCallAdapter<ProductDto>().adapt(
      () => _addProduct(product),
    );
  }

  Future<ProductDto> _updateProduct(ProductDto product) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<Either<ProductDto, Failure>>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/products',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ProductDto _value;
    try {
      _value = await compute(deserializeProductDto, _result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Either<ProductDto, Failure>> updateProduct(ProductDto product) {
    return RetrofitApiCallAdapter<ProductDto>().adapt(
      () => _updateProduct(product),
    );
  }

  Future<ProductDto> _deleteProduct(String id) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<Either<ProductDto, Failure>>(
      Options(method: 'DELETE', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/products',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ProductDto _value;
    try {
      _value = await compute(deserializeProductDto, _result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Either<ProductDto, Failure>> deleteProduct(String id) {
    return RetrofitApiCallAdapter<ProductDto>().adapt(() => _deleteProduct(id));
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main,avoid_redundant_argument_values

class _ProductApiV2Impl implements ProductApiV2Impl {
  _ProductApiV2Impl(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  Future<ApiResponse<ProductListDto>> _getProducts({
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'skip': skip,
      r'limit': limit,
      r'sortBy': await compute(serializeProductSortBy, sortBy),
      r'orderBy': await compute(serializeOrderBy, orderBy),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<Either<ApiResponse<ProductListDto>, Failure>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/products',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResponse<ProductListDto> _value;
    try {
      _value = await compute(
        deserializeApiResponseProductListDto,
        _result.data!,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Either<ApiResponse<ProductListDto>, Failure>> getProducts({
    int? skip,
    int? limit,
    ProductSortBy? sortBy,
    OrderBy? orderBy,
  }) {
    return RetrofitApiCallAdapter<ApiResponse<ProductListDto>>().adapt(
      () => _getProducts(
        skip: skip,
        limit: limit,
        sortBy: sortBy,
        orderBy: orderBy,
      ),
    );
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on

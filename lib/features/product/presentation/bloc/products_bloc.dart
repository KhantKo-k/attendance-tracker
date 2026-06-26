import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/product/domain/entities/product.dart';
import 'package:app_starter_kit_bloc/features/product/domain/usecases/get_products_use_case.dart';
import 'package:app_starter_kit_bloc/features/product/domain/usecases/search_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final SearchProductsUseCase searchProductsUseCase;

  ProductsBloc(
    this.getProductsUseCase,
    this.searchProductsUseCase,
  ) : super(const ProductsState()) {
    on<_FetchProducts>(_onFetchProducts);
    on<_LoadMore>(_onLoadMore);
    on<_SearchProducts>(_onSearchProducts);
    on<_ClearSearch>(_onClearSearch);
    on<_Refresh>(_onRefresh);
  }

  Future<void> _onFetchProducts(
    _FetchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(isLoading: true, skip: 0, hasMore: true, failure: null),
    );

    final result = await getProductsUseCase(skip: 0, limit: state.limit);

    result.fold(
      (data) => emit(
        state.copyWith(
          products: data.products,
          hasMore: data.skip + data.products.length < data.total,
          skip: data.skip + data.products.length,
          isLoading: false,
          failure: null,
        ),
      ),
      (failure) => emit(state.copyWith(failure: failure, isLoading: false)),
    );
  }

  Future<void> _onLoadMore(_LoadMore event, Emitter<ProductsState> emit) async {
    if (state.isLoadingMore || !state.hasMore) return;
    emit(state.copyWith(isLoadingMore: true));
    Future.delayed(const Duration(seconds: 2));

    final result = state.query == null
        ? await getProductsUseCase(skip: state.skip, limit: state.limit)
        : await searchProductsUseCase(
            query: state.query!,
            skip: state.skip,
            limit: state.limit,
          );

    result.fold(
      (data) {
        final updated = [...state.products, ...data.products];
        emit(
          state.copyWith(
            products: updated,
            skip: updated.length,
            hasMore: updated.length < data.total,
            isLoadingMore: false,
            failure: null,
          ),
        );
      },
      (failure) => emit(state.copyWith(failure: failure, isLoadingMore: false)),
    );
  }

  Future<void> _onSearchProducts(
    _SearchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        query: event.query,
        products: [],
        skip: 0,
        hasMore: true,
      ),
    );

    final result = await searchProductsUseCase(
      query: event.query,
      skip: 0,
      limit: state.limit,
    );

    result.fold(
      (data) => emit(
        state.copyWith(
          products: data.products,
          // skip: data.products.length,
          skip: data.skip + data.products.length,
          hasMore: data.skip + data.products.length < data.total,
          isLoading: false,
          failure: null,
        ),
      ),
      (failure) => emit(state.copyWith(failure: failure, isLoading: false)),
    );
  }

  Future<void> _onClearSearch(
    _ClearSearch event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        query: null,
        products: [],
        skip: 0,
        hasMore: true,
        failure: null,
      ),
    );
    add(const ProductsEvent.fetchProducts());
  }

  Future<void> _onRefresh(_Refresh event, Emitter<ProductsState> emit) async {
    if (state.isLoading) return;

    add(const ProductsEvent.fetchProducts());
  }
}

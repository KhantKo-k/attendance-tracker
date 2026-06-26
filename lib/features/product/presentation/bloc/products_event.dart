part of 'products_bloc.dart';

@freezed
abstract class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.fetchProducts() = _FetchProducts;

  const factory ProductsEvent.loadMore() = _LoadMore;

  const factory ProductsEvent.searchProducts(String query) =_SearchProducts;

  const factory ProductsEvent.clearSearch() = _ClearSearch;
  
  const factory ProductsEvent.refresh() = _Refresh;
}
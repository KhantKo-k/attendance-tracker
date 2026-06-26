part of 'product_detail_bloc.dart';

@freezed  
abstract class ProductDetailState with _$ProductDetailState {

  const factory ProductDetailState.initial() = ProductDetailInitialState;

  const factory ProductDetailState.loading() = ProductDetailLoadingState;

  const factory ProductDetailState.loaded(Product product) = ProductDetailLoadedState;

  const factory ProductDetailState.failure(Failure failure) = ProductDetailFailureState;
}
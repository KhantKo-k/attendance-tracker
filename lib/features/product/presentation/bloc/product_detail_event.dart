part of 'product_detail_bloc.dart';

@freezed 
abstract class ProductDetailEvent with _$ProductDetailEvent {
  const factory ProductDetailEvent.getProduct(String id)
    = _GetProduct;
}
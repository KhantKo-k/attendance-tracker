import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/product/domain/entities/product.dart';
import 'package:app_starter_kit_bloc/features/product/domain/usecases/get_product_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';
part 'product_detail_bloc.freezed.dart';

@injectable
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductUseCase getProductUseCase;

  ProductDetailBloc(this.getProductUseCase)
    : super(const ProductDetailInitialState()) {
    on<_GetProduct>(_onGetProduct);
  }

  Future<void> _onGetProduct(
    _GetProduct event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(const ProductDetailLoadingState());

    final result = await getProductUseCase(event.id);

    result.fold(
      (data) => emit(ProductDetailLoadedState(data)),
      (failure) => emit(ProductDetailFailureState(failure)),
    );
  }
}

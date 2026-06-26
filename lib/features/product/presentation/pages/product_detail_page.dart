import 'package:app_starter_kit_bloc/core/error/exceptions.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/features/product/domain/entities/product.dart';
import 'package:app_starter_kit_bloc/features/product/presentation/bloc/product_detail_bloc.dart';
import 'package:app_starter_kit_bloc/features/product/product_routes.dart';
import 'package:app_starter_kit_bloc/shared/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailBloc, ProductDetailState>(
      listener: (context, state) {
        if (state is ProductDetailFailureState) {
          _onFailure(context, state.failure);
        }
      },
      child: PopScope(
        canPop: context.canPop(),
        onPopInvokedWithResult: (didPop, _) =>
            !didPop ? _onBackPressed(context) : null,
        child: _buildScaffold(context),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(context.tr('productDetailPage.productDetail')),
      leading: IconButton(
        onPressed: () => _onBackPressed(context),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadingState) {
          return _buildLoading();
        }

        if (state is ProductDetailLoadedState) {
          return _buildProductDetails(Theme.of(context), state.product);
        }

        if (state is ProductDetailFailureState) {
          return _buildErrorState(context, state.failure);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(BuildContext context, Failure failure) {
    if (failure.exception is NotFoundException) {
      return _buildNotFoundState(context);
    }

    // Other errors will be handled by the global error handler
    return const SizedBox.shrink();
  }

  Widget _buildNotFoundState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: kPaddingMedium,
      children: [
        const Icon(Icons.error, size: IconSizes.large, color: Colors.red),
        Text(
          context.tr('productDetailPage.noProductData'),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildProductDetails(ThemeData theme, Product product) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(theme, product.thumbnail),
          const SizedBox(height: 16),
          Text(
            product.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.category,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(product.description, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 16),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(ThemeData theme, String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (_, _, _) => ColoredBox(
            color: theme.colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.image_not_supported,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  void _onBackPressed(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(ProductRoutes.products);
    }
  }

  void _onFailure(BuildContext context, Failure failure) {
    switch (failure.exception) {
      case NotFoundException():
        // Not found error is already handled in UI, no need to handle it here
        return;
    }

    GlobalErrorHandler().handleError(context, failure);
  }
}

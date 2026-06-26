import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/features/product/presentation/bloc/product_detail_bloc.dart';
import 'package:app_starter_kit_bloc/features/product/presentation/bloc/products_bloc.dart';
import 'package:app_starter_kit_bloc/features/product/presentation/pages/product_detail_page.dart';
import 'package:app_starter_kit_bloc/features/product/presentation/pages/products_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductRoutes {
  static const products = '/products';
  static const productDetails = '/products/:id';

  static final routes = [
    GoRoute(
      path: products,
      builder: (context, state) => BlocProvider(
        create: (context) => serviceLocator.get<ProductsBloc>()
          ..add(const ProductsEvent.fetchProducts()),
        child: const ProductsPage(),
      ),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return BlocProvider(
              create: (context) => serviceLocator.get<ProductDetailBloc>()
              ..add(ProductDetailEvent.getProduct(id)),
              child: ProductDetailPage(productId: id),
            );
          },
        ),
      ],
    ),
  ];
}

extension ProductRoutesExtension on AppRouter {
  void goToProductDetails(BuildContext context, String id) {
    context.push('${ProductRoutes.products}/$id');
  }
}

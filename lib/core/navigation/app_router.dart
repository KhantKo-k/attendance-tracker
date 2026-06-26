import 'package:app_starter_kit_bloc/core/navigation/router_refresh_listenable.dart';
import 'package:app_starter_kit_bloc/features/auth/auth_routes.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/home/presentation/home_routes.dart';
import 'package:app_starter_kit_bloc/features/product/product_routes.dart';
import 'package:app_starter_kit_bloc/core/logging/app_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

class AppNavigatorKey {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
}

@singleton
class AppRouter {
  String? deeplink;

  late final GoRouter router;

  AppRouter(AuthBloc authBloc) {
    router = GoRouter(
      navigatorKey: AppNavigatorKey.navigatorKey,
      routes: [...HomeRoutes.routes, ...AuthRoutes.routes],
      redirect: (context, state) => _redirect(authBloc, state),
      refreshListenable: RouterRefreshListenable(authBloc.stream),
    );
  }

  String? _redirect(AuthBloc authBloc, GoRouterState state) {
    final location = state.uri.path;
    AppLogger().info(
      'Redirect — location: $location, fullPath: ${state.fullPath}',
    );
    final authState = authBloc.state;
    final isAuthenticated = authState is Authenticated;
    AppLogger().info('Auth state: $authState');

    final productDetailPath = _productDetailPath(state);

    if (!isAuthenticated) {
      if (productDetailPath != null) {
        deeplink = productDetailPath;
        AppLogger().info('Product deeplink saved: $deeplink');
      }

      if (location == HomeRoutes.landing || location == AuthRoutes.login) {
        return null;
      }

      if (productDetailPath != null) {
        return AuthRoutes.login;
      }

      AppLogger().info('Not authenticated, redirecting to landing');
      return HomeRoutes.landing;
    }

    if (deeplink != null) {
      final target = deeplink!;
      deeplink = null;
      if (location != target) {
        AppLogger().info('Login success, redirecting to deeplink: $target');
        return target;
      }
    }

    if (location == AuthRoutes.login) {
      AppLogger().info('Login success, redirecting to products');
      return ProductRoutes.products;
    }

    return null;
  }

  String? _productDetailPath(GoRouterState state) {
    final id = state.pathParameters['id'];
    if (id != null && id.isNotEmpty) {
      return '${ProductRoutes.products}/$id';
    }

    final segments = state.uri.pathSegments;
    if (segments.length == 2 &&
        segments.first == 'products' &&
        segments[1].isNotEmpty) {
      return '${ProductRoutes.products}/${segments[1]}';
    }

    return null;
  }
}

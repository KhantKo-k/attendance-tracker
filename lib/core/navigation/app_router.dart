import 'package:app_starter_kit_bloc/core/navigation/router_refresh_listenable.dart';
import 'package:app_starter_kit_bloc/features/admin/admin_routes.dart';
import 'package:app_starter_kit_bloc/features/attendance/attendance_routes.dart';
import 'package:app_starter_kit_bloc/features/auth/auth_routes.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user_role.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/home/presentation/home_routes.dart';
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
  late final GoRouter router;

  AppRouter(AuthBloc authBloc) {
    router = GoRouter(
      navigatorKey: AppNavigatorKey.navigatorKey,
      routes: [...HomeRoutes.routes(authBloc), ...AuthRoutes.routes],
      redirect: (context, state) => _redirect(authBloc, state),
      refreshListenable: RouterRefreshListenable(authBloc.stream),
    );
  }

  String? _redirect(AuthBloc authBloc, GoRouterState state) {
    final location = state.uri.path;
    AppLogger().info('Redirect — location: $location');
    final authState = authBloc.state;
    final isAuthenticated = authState is Authenticated;

    final isAuthRoute =
        location == AuthRoutes.login || location == AuthRoutes.register;
    final isLanding = location == HomeRoutes.landing;

    if (!isAuthenticated) {
      if (isLanding || isAuthRoute) {
        return null;
      }
      return HomeRoutes.landing;
    }

    final user = authState.user;
    final homePath = user.role == UserRole.admin
        ? AdminRoutes.dashboard
        : AttendanceRoutes.home;

    if (isLanding || isAuthRoute) {
      return homePath;
    }

    return null;
  }
}

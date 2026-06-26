import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/pages/login_page.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static const login = '/login';

  static final routes = [
    GoRoute(path: login, builder: (context, state) => const LoginPage()),
  ];
}

extension AuthRoutesExtension on AppRouter {
  void navigateToLogin() {
    router.go(AuthRoutes.login);
  }
}

import 'package:attendance_tracker/core/navigation/app_router.dart';
import 'package:attendance_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:attendance_tracker/features/auth/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static const login = '/login';
  static const register = '/register';

  static final routes = [
    GoRoute(path: login, builder: (context, state) => const LoginPage()),
    GoRoute(
      path: register,
      builder: (context, state) => const RegisterPage(),
    ),
  ];
}

extension AuthRoutesExtension on AppRouter {
  void navigateToLogin() {
    router.go(AuthRoutes.login);
  }

  void navigateToRegister() {
    router.go(AuthRoutes.register);
  }
}

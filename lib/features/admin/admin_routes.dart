import 'package:attendance_tracker/core/di/service_locator.dart';
import 'package:attendance_tracker/core/navigation/app_router.dart';
import 'package:attendance_tracker/features/admin/domain/use_cases/admin_use_cases.dart';
import 'package:attendance_tracker/features/admin/presentation/blocs/admin_user_history_bloc.dart';
import 'package:attendance_tracker/features/admin/presentation/pages/admin_user_history_page.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminRoutes {
  static const dashboard = '/admin/dashboard';
  static const users = '/admin/users';
  static const userHistory = '/admin/users/:userId/history';

  static String userHistoryPath(String userId) => '/admin/users/$userId/history';

  static GoRoute userHistoryRoute() => GoRoute(
    path: userHistory,
    builder: (context, state) {
      final selectedUser = state.extra as User;
      return BlocProvider(
        create: (_) => AdminUserHistoryBloc(
          getUserAttendanceHistoryUseCase:
              serviceLocator<GetUserAttendanceHistoryUseCase>(),
          user: selectedUser,
        )..add(const AdminUserHistoryStarted()),
        child: AdminUserHistoryPage(user: selectedUser),
      );
    },
  );
}

extension AdminRoutesExtension on AppRouter {
  void navigateToAdminDashboard() {
    router.go(AdminRoutes.dashboard);
  }

  void navigateToAdminUsers() {
    router.go(AdminRoutes.users);
  }
}

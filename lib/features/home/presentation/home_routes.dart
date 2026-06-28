import 'package:attendance_tracker/core/di/service_locator.dart';
import 'package:attendance_tracker/features/admin/admin_routes.dart';
import 'package:attendance_tracker/features/admin/domain/use_cases/admin_use_cases.dart';
import 'package:attendance_tracker/features/admin/presentation/blocs/admin_dashboard_bloc.dart';
import 'package:attendance_tracker/features/admin/presentation/blocs/admin_users_bloc.dart';
import 'package:attendance_tracker/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:attendance_tracker/features/admin/presentation/pages/admin_users_page.dart';
import 'package:attendance_tracker/features/attendance/attendance_routes.dart';
import 'package:attendance_tracker/features/attendance/domain/use_cases/attendance_use_cases.dart';
import 'package:attendance_tracker/features/attendance/presentation/blocs/attendance_history_bloc.dart';
import 'package:attendance_tracker/features/attendance/presentation/blocs/attendance_home_bloc.dart';
import 'package:attendance_tracker/features/attendance/presentation/pages/attendance_history_page.dart';
import 'package:attendance_tracker/features/attendance/presentation/pages/attendance_home_page.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:attendance_tracker/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:attendance_tracker/features/home/presentation/pages/home_page.dart';
import 'package:attendance_tracker/features/home/presentation/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _adminDashboardNavigatorKey = GlobalKey<NavigatorState>();
final _adminUsersNavigatorKey = GlobalKey<NavigatorState>();
final _attendanceHomeNavigatorKey = GlobalKey<NavigatorState>();
final _attendanceHistoryNavigatorKey = GlobalKey<NavigatorState>();

class HomeRoutes {
  static const landing = '/';

  static List<RouteBase> routes(AuthBloc authBloc) => [
    GoRoute(path: landing, builder: (context, state) => const LandingPage()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (context, authState) {
            if (authState is! Authenticated) {
              return const SizedBox.shrink();
            }
            return HomePage(
              navigationShell: navigationShell,
              user: authState.user,
            );
          },
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _adminDashboardNavigatorKey,
          routes: [
            GoRoute(
              path: AdminRoutes.dashboard,
              builder: (context, state) => BlocProvider(
                create: (_) => AdminDashboardBloc(
                  getDashboardStatsUseCase:
                      serviceLocator<GetDashboardStatsUseCase>(),
                )..add(const AdminDashboardStarted()),
                child: const AdminDashboardPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _adminUsersNavigatorKey,
          routes: [
            GoRoute(
              path: AdminRoutes.users,
              builder: (context, state) => BlocProvider(
                create: (_) => AdminUsersBloc(
                  getUsersUseCase: serviceLocator<GetUsersUseCase>(),
                )..add(const AdminUsersStarted()),
                child: const AdminUsersPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _attendanceHomeNavigatorKey,
          routes: [
            GoRoute(
              path: AttendanceRoutes.home,
              builder: (context, state) {
                final user = _requireUser(context);
                return BlocProvider(
                  create: (_) => AttendanceHomeBloc(
                    getAttendanceStatusUseCase:
                        serviceLocator<GetAttendanceStatusUseCase>(),
                    checkInUseCase: serviceLocator<CheckInUseCase>(),
                    checkOutUseCase: serviceLocator<CheckOutUseCase>(),
                    syncPendingAttendanceUseCase:
                        serviceLocator<SyncPendingAttendanceUseCase>(),
                    user: user,
                  )..add(const AttendanceHomeStarted()),
                  child: const AttendanceHomePage(),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _attendanceHistoryNavigatorKey,
          routes: [
            GoRoute(
              path: AttendanceRoutes.history,
              builder: (context, state) {
                final user = _requireUser(context);
                return BlocProvider(
                  create: (_) => AttendanceHistoryBloc(
                    getMyAttendanceHistoryUseCase:
                        serviceLocator<GetMyAttendanceHistoryUseCase>(),
                    syncPendingAttendanceUseCase:
                        serviceLocator<SyncPendingAttendanceUseCase>(),
                    userId: user.id,
                  )..add(const AttendanceHistoryStarted()),
                  child: const AttendanceHistoryPage(),
                );
              },
            ),
          ],
        ),
      ],
    ),
    AdminRoutes.userHistoryRoute(),
  ];

  static User _requireUser(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    if (state is Authenticated) {
      return state.user;
    }
    throw StateError('User must be authenticated');
  }
}

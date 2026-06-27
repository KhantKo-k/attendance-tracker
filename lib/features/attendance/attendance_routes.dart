import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/features/attendance/domain/use_cases/attendance_use_cases.dart';
import 'package:app_starter_kit_bloc/features/attendance/presentation/blocs/attendance_history_bloc.dart';
import 'package:app_starter_kit_bloc/features/attendance/presentation/blocs/attendance_home_bloc.dart';
import 'package:app_starter_kit_bloc/features/attendance/presentation/pages/attendance_history_page.dart';
import 'package:app_starter_kit_bloc/features/attendance/presentation/pages/attendance_home_page.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AttendanceRoutes {
  static const home = '/attendance';
  static const history = '/attendance/history';

  static List<RouteBase> userShellRoutes(User user) => [
    GoRoute(
      path: home,
      builder: (context, state) => BlocProvider(
        create: (_) => AttendanceHomeBloc(
          getAttendanceStatusUseCase: serviceLocator<GetAttendanceStatusUseCase>(),
          checkInUseCase: serviceLocator<CheckInUseCase>(),
          checkOutUseCase: serviceLocator<CheckOutUseCase>(),
          syncPendingAttendanceUseCase:
              serviceLocator<SyncPendingAttendanceUseCase>(),
          user: user,
        )..add(const AttendanceHomeStarted()),
        child: const AttendanceHomePage(),
      ),
    ),
    GoRoute(
      path: history,
      builder: (context, state) => BlocProvider(
        create: (_) => AttendanceHistoryBloc(
          getMyAttendanceHistoryUseCase:
              serviceLocator<GetMyAttendanceHistoryUseCase>(),
          syncPendingAttendanceUseCase:
              serviceLocator<SyncPendingAttendanceUseCase>(),
          userId: user.id,
        )..add(const AttendanceHistoryStarted()),
        child: const AttendanceHistoryPage(),
      ),
    ),
  ];
}

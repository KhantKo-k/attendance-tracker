import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/features/notification/presentation/bloc/notifications_bloc.dart';
import 'package:app_starter_kit_bloc/features/notification/presentation/pages/notifications_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationRoutes {
  static const notifications = '/notifications';

  static final routes = [
    GoRoute(
      path: notifications,
      builder: (context, state) => BlocProvider(
        create: (context) => serviceLocator.get<NotificationsBloc>()
          ..add(const NotificationsEvent.fetchNotifications()),
        child: const NotificationsPage(),
      ),
    ),
  ];
}

extension NotificationRoutesExtension on AppRouter {
  void goToNotifications(BuildContext context) {
    context.go(NotificationRoutes.notifications);
  }
}

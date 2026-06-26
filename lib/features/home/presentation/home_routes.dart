import 'package:app_starter_kit_bloc/features/experiment/experiment_routes.dart';
import 'package:app_starter_kit_bloc/features/home/presentation/pages/home_page.dart';
import 'package:app_starter_kit_bloc/features/home/presentation/pages/landing_page.dart';
import 'package:app_starter_kit_bloc/features/notification/notification_routes.dart';
import 'package:app_starter_kit_bloc/features/profile/profile_routes.dart';
import 'package:app_starter_kit_bloc/features/product/product_routes.dart';
import 'package:app_starter_kit_bloc/features/to-do/note_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _productsNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();
final _notificationsNavigatorKey = GlobalKey<NavigatorState>();
final _notesNavigatorKey = GlobalKey<NavigatorState>();
final _experimentNavigatorKey = GlobalKey<NavigatorState>();

class HomeRoutes {
  static const landing = '/';
  static const products = ProductRoutes.products;
  static const profile = ProfileRoutes.profile;
  static const notifications = NotificationRoutes.notifications;
  static const notes = NoteRoutes.notes;
  static const experiment = ExperimentRoutes.experiment;

  static final routes = [
    GoRoute(path: landing, builder: (context, state) => const LandingPage()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _productsNavigatorKey,
          routes: [...ProductRoutes.routes],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: ProfileRoutes.routes,
        ),
        StatefulShellBranch(
          navigatorKey: _notificationsNavigatorKey,
          routes: [...NotificationRoutes.routes],
        ),
        StatefulShellBranch(
          navigatorKey: _notesNavigatorKey,
          routes: [...NoteRoutes.routes],
        ),
        StatefulShellBranch(
          navigatorKey: _experimentNavigatorKey,
          routes: [
            ...ExperimentRoutes.shellRoutes,
          ],
        )
      ],
    ),
  ];
}

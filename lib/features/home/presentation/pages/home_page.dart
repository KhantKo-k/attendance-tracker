import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user_role.dart';
import 'package:attendance_tracker/features/localization/presentation/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.navigationShell,
    required this.user,
  });

  final StatefulNavigationShell navigationShell;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    final isAdmin = user.role == UserRole.admin;
    final branchOffset = isAdmin ? 0 : 2;
    final currentIndex = navigationShell.currentIndex - branchOffset;

    return NavigationBar(
      selectedIndex: currentIndex.clamp(0, 1),
      onDestinationSelected: (index) {
        navigationShell.goBranch(index + branchOffset);
      },
      destinations: isAdmin
          ? _adminDestinations(context)
          : _userDestinations(context),
    );
  }

  List<NavigationDestination> _adminDestinations(BuildContext context) {
    return [
      NavigationDestination(
        icon: const Icon(Icons.dashboard_outlined),
        selectedIcon: const Icon(Icons.dashboard_rounded),
        label: context.tr('homePage.dashboard'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.people_outline),
        selectedIcon: const Icon(Icons.people_rounded),
        label: context.tr('homePage.users'),
      ),
    ];
  }

  List<NavigationDestination> _userDestinations(BuildContext context) {
    return [
      NavigationDestination(
        icon: const Icon(Icons.home_outlined),
        selectedIcon: const Icon(Icons.home_rounded),
        label: context.tr('homePage.home'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.history),
        selectedIcon: const Icon(Icons.history_rounded),
        label: context.tr('homePage.history'),
      ),
    ];
  }
}

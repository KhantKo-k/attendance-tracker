import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: context.tr('productPage.products'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: context.tr('profilePage.title'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_alt_outlined),
          label: 'Notes',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.playlist_add), label: 'Experiment'),
      ],
      currentIndex: navigationShell.currentIndex,
      onTap: (index) {
        navigationShell.goBranch(index);
      },
    );
  }
}

class ChildPage extends StatelessWidget {
  final String pageName;

  const ChildPage({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(pageName));
  }
}

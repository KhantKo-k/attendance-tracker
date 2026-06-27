import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/admin/presentation/blocs/admin_dashboard_bloc.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/shared/theme/app_colors.dart';
import 'package:app_starter_kit_bloc/shared/theme/dimensions.dart';
import 'package:app_starter_kit_bloc/shared/widgets/app_bar_settings_actions.dart';
import 'package:app_starter_kit_bloc/shared/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminDashboardBloc, AdminDashboardState>(
      listener: _onStateChanged,
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context, state),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(context.tr('adminDashboardPage.title')),
      actions: [
        const AppBarSettingsActions(),
        IconButton(
          onPressed: () => _onLogoutPressed(context),
          tooltip: context.tr('common.logout'),
          icon: const Icon(Icons.logout_rounded),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, AdminDashboardState state) {
    if (state is AdminDashboardLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AdminDashboardFailure) {
      return Center(child: Text(state.failure.exception.toString()));
    }

    if (state is AdminDashboardLoaded) {
      return RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: ListView(
          padding: const EdgeInsets.all(kPaddingMedium),
          children: [
            _buildStatCard(
              context,
              icon: Icons.people_outline_rounded,
              iconColor: Theme.of(context).colorScheme.primary,
              iconBackground: Theme.of(context).colorScheme.primaryContainer,
              title: context.tr('adminDashboardPage.totalUsers'),
              value: '${state.stats.totalUsers}',
            ),
            const SizedBox(height: kPaddingMedium),
            _buildStatCard(
              context,
              icon: Icons.login_rounded,
              iconColor: AppColors.success,
              iconBackground: AppColors.successContainer,
              title: context.tr('adminDashboardPage.todayCheckIns'),
              value: '${state.stats.todayCheckIns}',
            ),
            const SizedBox(height: kPaddingMedium),
            _buildStatCard(
              context,
              icon: Icons.logout_rounded,
              iconColor: Theme.of(context).colorScheme.secondary,
              iconBackground: Theme.of(context).colorScheme.secondaryContainer,
              title: context.tr('adminDashboardPage.todayCheckOuts'),
              value: '${state.stats.todayCheckOuts}',
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String value,
  }) {
    return StatCard(
      icon: icon,
      iconColor: iconColor,
      iconBackground: iconBackground,
      title: title,
      value: value,
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<AdminDashboardBloc>().add(const AdminDashboardRefreshed());
    await context.read<AdminDashboardBloc>().stream.firstWhere(
      (state) => state is! AdminDashboardLoading,
    );
  }

  Future<void> _onLogoutPressed(BuildContext context) async {
    context.read<AuthBloc>().add(const LogoutRequested());
  }

  void _onStateChanged(BuildContext context, AdminDashboardState state) {
    if (state is AdminDashboardFailure) {
      GlobalErrorHandler().handleError(context, state.failure);
    }
  }
}

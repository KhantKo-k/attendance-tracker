import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/attendance/domain/entities/attendance_entities.dart';
import 'package:app_starter_kit_bloc/features/attendance/presentation/blocs/attendance_home_bloc.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/shared/theme/app_colors.dart';
import 'package:app_starter_kit_bloc/shared/theme/dimensions.dart';
import 'package:app_starter_kit_bloc/shared/widgets/app_bar_settings_actions.dart';
import 'package:app_starter_kit_bloc/shared/widgets/app_card.dart';
import 'package:app_starter_kit_bloc/shared/widgets/icon_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceHomePage extends StatelessWidget {
  const AttendanceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceHomeBloc, AttendanceHomeState>(
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
      title: Text(context.tr('attendancePage.title')),
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

  Widget _buildBody(BuildContext context, AttendanceHomeState state) {
    if (state is AttendanceHomeLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AttendanceHomeFailure) {
      return _buildRetryView(context);
    }

    if (state is AttendanceHomeLoaded) {
      return _buildLoadedContent(context, state.status);
    }

    return const SizedBox.shrink();
  }

  Widget _buildRetryView(BuildContext context) {
    return Center(
      child: FilledButton.icon(
        onPressed: () {
          context.read<AttendanceHomeBloc>().add(const AttendanceHomeStarted());
        },
        icon: const Icon(Icons.refresh_rounded),
        label: Text(context.tr('attendancePage.retry')),
      ),
    );
  }

  Widget _buildLoadedContent(BuildContext context, AttendanceStatus status) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatusCard(context, status),
          const SizedBox(height: kPaddingMedium),
          _buildLocationCard(context, status),
          const Spacer(),
          _buildActionButtons(context, status),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, AttendanceStatus status) {
    final theme = Theme.of(context);
    final statusData = _resolveStatusData(context, status);

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconCircle(
            icon: statusData.icon,
            color: statusData.color,
            backgroundColor: statusData.backgroundColor,
            size: 52,
          ),
          const SizedBox(width: kPaddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('attendancePage.currentStatus'),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  statusData.label,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: statusData.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (status.openSessionFromPriorDay) ...[
                  const SizedBox(height: kPaddingSmall),
                  Container(
                    padding: const EdgeInsets.all(kPaddingSmall),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: kBorderRadius,
                    ),
                    child: Text(
                      context.tr('attendancePage.openCheckInWarning'),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  _StatusData _resolveStatusData(BuildContext context, AttendanceStatus status) {
    final colors = Theme.of(context).colorScheme;

    if (status.isDayComplete) {
      return _StatusData(
        label: context.tr('attendancePage.statusComplete'),
        icon: Icons.check_circle_outline_rounded,
        color: colors.primary,
        backgroundColor: colors.primaryContainer,
      );
    }
    if (status.isCheckedIn) {
      return _StatusData(
        label: context.tr('attendancePage.statusCheckedIn'),
        icon: Icons.login_rounded,
        color: AppColors.success,
        backgroundColor: AppColors.successContainer,
      );
    }
    if (status.hasCheckedInToday && status.hasCheckedOutToday) {
      return _StatusData(
        label: context.tr('attendancePage.statusCheckedOut'),
        icon: Icons.logout_rounded,
        color: colors.secondary,
        backgroundColor: colors.secondaryContainer,
      );
    }
    return _StatusData(
      label: context.tr('attendancePage.statusNotCheckedIn'),
      icon: Icons.schedule_rounded,
      color: colors.onSurfaceVariant,
      backgroundColor: colors.surfaceContainerHighest,
    );
  }

  Widget _buildLocationCard(BuildContext context, AttendanceStatus status) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final lastLog = status.lastLog;

    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: kPaddingMedium,
        vertical: kPaddingSmall,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: IconCircle(
          icon: Icons.location_on_outlined,
          color: colors.secondary,
          backgroundColor: colors.secondaryContainer,
        ),
        title: Text(
          context.tr('attendancePage.lastKnownLocation'),
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          lastLog?.address ??
              '${lastLog?.latitude ?? '-'}, ${lastLog?.longitude ?? '-'}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, AttendanceStatus status) {
    final isLoading = context.select(
      (AttendanceHomeBloc bloc) => bloc.state is AttendanceHomeLoading,
    );
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: isLoading || !status.canCheckIn
              ? null
              : () => _onCheckInPressed(context),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.success,
            foregroundColor: Colors.white,
            disabledBackgroundColor: colors.surfaceContainerHighest,
          ),
          icon: const Icon(Icons.login_rounded),
          label: Text(context.tr('attendancePage.checkIn')),
        ),
        const SizedBox(height: kPaddingMedium),
        OutlinedButton.icon(
          onPressed: isLoading || !status.canCheckOut
              ? null
              : () => _onCheckOutPressed(context),
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.secondary,
            side: BorderSide(color: colors.secondary),
          ),
          icon: const Icon(Icons.logout_rounded),
          label: Text(context.tr('attendancePage.checkOut')),
        ),
      ],
    );
  }

  void _onCheckInPressed(BuildContext context) {
    context.read<AttendanceHomeBloc>().add(const AttendanceCheckInRequested());
  }

  void _onCheckOutPressed(BuildContext context) {
    context.read<AttendanceHomeBloc>().add(const AttendanceCheckOutRequested());
  }

  Future<void> _onLogoutPressed(BuildContext context) async {
    context.read<AuthBloc>().add(const LogoutRequested());
  }

  Future<void> _onStateChanged(
    BuildContext context,
    AttendanceHomeState state,
  ) async {
    if (state is AttendanceHomeFailure) {
      await GlobalErrorHandler().handleError(context, state.failure);
    }
  }
}

class _StatusData {
  const _StatusData({
    required this.label,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  final String label;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
}

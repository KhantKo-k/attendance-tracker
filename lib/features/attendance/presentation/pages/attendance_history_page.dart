import 'package:attendance_tracker/core/error/global_error_handler.dart';
import 'package:attendance_tracker/features/attendance/domain/entities/attendance_entities.dart';
import 'package:attendance_tracker/features/attendance/presentation/blocs/attendance_history_bloc.dart';
import 'package:attendance_tracker/features/localization/presentation/extensions/localization_extension.dart';
import 'package:attendance_tracker/shared/theme/app_colors.dart';
import 'package:attendance_tracker/shared/theme/dimensions.dart';
import 'package:attendance_tracker/shared/widgets/app_bar_settings_actions.dart';
import 'package:attendance_tracker/shared/widgets/empty_state.dart';
import 'package:attendance_tracker/shared/widgets/icon_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceHistoryPage extends StatelessWidget {
  const AttendanceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceHistoryBloc, AttendanceHistoryState>(
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
      title: Text(context.tr('attendanceHistoryPage.title')),
      actions: const [AppBarSettingsActions()],
    );
  }

  Widget _buildBody(BuildContext context, AttendanceHistoryState state) {
    if (state is AttendanceHistoryLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AttendanceHistoryFailure) {
      return Center(child: Text(state.failure.exception.toString()));
    }

    if (state is AttendanceHistoryLoaded) {
      return RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: _buildLogList(context, state.logs),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildLogList(BuildContext context, List<AttendanceLog> logs) {
    if (logs.isEmpty) {
      return ListView(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.35,
            child: EmptyState(
              icon: Icons.history_rounded,
              message: context.tr('attendanceHistoryPage.noRecords'),
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(kPaddingMedium),
      itemCount: logs.length,
      separatorBuilder: (_, _) => const SizedBox(height: kPaddingSmall),
      itemBuilder: (context, index) => _buildLogTile(context, logs[index]),
    );
  }

  Widget _buildLogTile(BuildContext context, AttendanceLog log) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isCheckIn = log.type == AttendanceType.checkIn;
    final typeLabel = isCheckIn
        ? context.tr('attendanceHistoryPage.checkIn')
        : context.tr('attendanceHistoryPage.checkOut');
    final iconColor = isCheckIn ? AppColors.success : colors.secondary;
    final iconBackground =
        isCheckIn ? AppColors.successContainer : colors.secondaryContainer;

    return Card(
      child: ListTile(
        leading: IconCircle(
          icon: isCheckIn ? Icons.login_rounded : Icons.logout_rounded,
          color: iconColor,
          backgroundColor: iconBackground,
        ),
        title: Text(
          typeLabel,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${_formatDateTime(log.timestamp)}\n${log.address ?? '${log.latitude}, ${log.longitude}'}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        trailing: log.isPending
            ? Chip(label: Text(context.tr('attendanceHistoryPage.pending')))
            : null,
      ),
    );
  }

  String _formatDateTime(DateTime timestamp) {
    return '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')} '
        '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<AttendanceHistoryBloc>().add(
      const AttendanceHistoryRefreshed(),
    );
    await context.read<AttendanceHistoryBloc>().stream.firstWhere(
      (state) => state is! AttendanceHistoryLoading,
    );
  }

  void _onStateChanged(BuildContext context, AttendanceHistoryState state) {
    if (state is AttendanceHistoryFailure) {
      GlobalErrorHandler().handleError(context, state.failure);
    }
  }
}

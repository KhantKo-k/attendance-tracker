import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/admin/presentation/blocs/admin_user_history_bloc.dart';
import 'package:app_starter_kit_bloc/features/attendance/domain/entities/attendance_entities.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/shared/theme/app_colors.dart';
import 'package:app_starter_kit_bloc/shared/theme/dimensions.dart';
import 'package:app_starter_kit_bloc/shared/widgets/empty_state.dart';
import 'package:app_starter_kit_bloc/shared/widgets/icon_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUserHistoryPage extends StatelessWidget {
  const AdminUserHistoryPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminUserHistoryBloc, AdminUserHistoryState>(
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
      title: Text(
        context.tr(
          'adminUserHistoryPage.title',
          namedArgs: {'name': user.name},
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AdminUserHistoryState state) {
    return Column(
      children: [
        _buildFilterBar(context),
        Expanded(child: _buildContent(context, state)),
      ],
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingMedium),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _pickStartDate(context),
              icon: const Icon(Icons.date_range_rounded),
              label: Text(context.tr('adminUserHistoryPage.startDate')),
            ),
          ),
          const SizedBox(width: kPaddingMedium),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _pickEndDate(context),
              icon: const Icon(Icons.event_rounded),
              label: Text(context.tr('adminUserHistoryPage.endDate')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, AdminUserHistoryState state) {
    if (state is AdminUserHistoryLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AdminUserHistoryFailure) {
      return Center(child: Text(state.failure.exception.toString()));
    }

    if (state is AdminUserHistoryLoaded) {
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
              icon: Icons.filter_list_off_rounded,
              message: context.tr('adminUserHistoryPage.noRecords'),
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
        ? context.tr('adminUserHistoryPage.checkIn')
        : context.tr('adminUserHistoryPage.checkOut');

    return Card(
      child: ListTile(
        leading: IconCircle(
          icon: isCheckIn ? Icons.login_rounded : Icons.logout_rounded,
          color: isCheckIn ? AppColors.success : colors.secondary,
          backgroundColor:
              isCheckIn ? AppColors.successContainer : colors.secondaryContainer,
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
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickStartDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (date == null || !context.mounted) {
      return;
    }
    context.read<AdminUserHistoryBloc>().add(
      AdminUserHistoryFilterChanged(startDate: date),
    );
  }

  Future<void> _pickEndDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (date == null || !context.mounted) {
      return;
    }
    context.read<AdminUserHistoryBloc>().add(
      AdminUserHistoryFilterChanged(endDate: date),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<AdminUserHistoryBloc>().add(const AdminUserHistoryRefreshed());
    await context.read<AdminUserHistoryBloc>().stream.firstWhere(
      (state) => state is! AdminUserHistoryLoading,
    );
  }

  void _onStateChanged(BuildContext context, AdminUserHistoryState state) {
    if (state is AdminUserHistoryFailure) {
      GlobalErrorHandler().handleError(context, state.failure);
    }
  }
}

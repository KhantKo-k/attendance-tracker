import 'package:attendance_tracker/core/error/global_error_handler.dart';
import 'package:attendance_tracker/features/admin/presentation/blocs/admin_user_history_bloc.dart';
import 'package:attendance_tracker/features/attendance/domain/entities/attendance_entities.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:attendance_tracker/features/localization/presentation/extensions/localization_extension.dart';
import 'package:attendance_tracker/shared/theme/app_colors.dart';
import 'package:attendance_tracker/shared/theme/dimensions.dart';
import 'package:attendance_tracker/shared/widgets/empty_state.dart';
import 'package:attendance_tracker/shared/widgets/icon_circle.dart';
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
        _buildFilterBar(context, state),
        Expanded(child: _buildContent(context, state)),
      ],
    );
  }

  Widget _buildFilterBar(BuildContext context, AdminUserHistoryState state) {
    final hasActiveFilters = state.startDate != null || state.endDate != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        kPaddingMedium,
        kPaddingMedium,
        kPaddingMedium,
        kPaddingSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDateFilterField(
                  context,
                  label: context.tr('adminUserHistoryPage.startDate'),
                  selectedDate: state.startDate,
                  onTap: () => _pickStartDate(context, state),
                  onClear: state.startDate != null
                      ? () => _clearStartDate(context)
                      : null,
                ),
              ),
              const SizedBox(width: kPaddingMedium),
              Expanded(
                child: _buildDateFilterField(
                  context,
                  label: context.tr('adminUserHistoryPage.endDate'),
                  selectedDate: state.endDate,
                  onTap: () => _pickEndDate(context, state),
                  onClear: state.endDate != null
                      ? () => _clearEndDate(context)
                      : null,
                ),
              ),
            ],
          ),
          if (hasActiveFilters) ...[
            const SizedBox(height: kPaddingSmall),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _clearAllFilters(context),
                icon: const Icon(Icons.filter_alt_off_rounded, size: 18),
                label: Text(context.tr('adminUserHistoryPage.clearFilters')),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateFilterField(
    BuildContext context, {
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
    VoidCallback? onClear,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final hasDate = selectedDate != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        isEmpty: !hasDate,
        decoration: InputDecoration(
          labelText: label,
          hintText: context.tr('adminUserHistoryPage.selectDate'),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: kPaddingMedium,
            vertical: kPaddingSmall,
          ),
          prefixIcon: Icon(
            Icons.calendar_today_rounded,
            size: 20,
            color: hasDate ? colors.primary : colors.onSurfaceVariant,
          ),
          suffixIcon: hasDate && onClear != null
              ? IconButton(
                  icon: const Icon(Icons.close_rounded, size: 18),
                  onPressed: onClear,
                  tooltip: context.tr('adminUserHistoryPage.clearDate'),
                )
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        child: hasDate
            ? Text(
                _formatFilterDate(selectedDate),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox.shrink(),
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

  String _formatFilterDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickStartDate(
    BuildContext context,
    AdminUserHistoryState state,
  ) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: state.endDate ?? DateTime.now(),
      initialDate: state.startDate ?? state.endDate ?? DateTime.now(),
    );
    if (date == null || !context.mounted) {
      return;
    }
    context.read<AdminUserHistoryBloc>().add(
      AdminUserHistoryFilterChanged(startDate: date),
    );
  }

  Future<void> _pickEndDate(
    BuildContext context,
    AdminUserHistoryState state,
  ) async {
    final date = await showDatePicker(
      context: context,
      firstDate: state.startDate ?? DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: state.endDate ?? state.startDate ?? DateTime.now(),
    );
    if (date == null || !context.mounted) {
      return;
    }
    context.read<AdminUserHistoryBloc>().add(
      AdminUserHistoryFilterChanged(endDate: date),
    );
  }

  void _clearStartDate(BuildContext context) {
    context.read<AdminUserHistoryBloc>().add(
      const AdminUserHistoryFilterChanged(clearStartDate: true),
    );
  }

  void _clearEndDate(BuildContext context) {
    context.read<AdminUserHistoryBloc>().add(
      const AdminUserHistoryFilterChanged(clearEndDate: true),
    );
  }

  void _clearAllFilters(BuildContext context) {
    context.read<AdminUserHistoryBloc>().add(
      const AdminUserHistoryFilterChanged(clearAll: true),
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

import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/admin/admin_routes.dart';
import 'package:app_starter_kit_bloc/features/admin/presentation/blocs/admin_users_bloc.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/shared/theme/dimensions.dart';
import 'package:app_starter_kit_bloc/shared/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminUsersBloc, AdminUsersState>(
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
    return AppBar(title: Text(context.tr('adminUsersPage.title')));
  }

  Widget _buildBody(BuildContext context, AdminUsersState state) {
    return Column(
      children: [
        _buildSearchField(context),
        Expanded(child: _buildContent(context, state)),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        kPaddingMedium,
        kPaddingMedium,
        kPaddingMedium,
        kPaddingSmall,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded),
          labelText: context.tr('adminUsersPage.searchUsers'),
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildContent(BuildContext context, AdminUsersState state) {
    if (state is AdminUsersLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AdminUsersFailure) {
      return Center(child: Text(state.failure.exception.toString()));
    }

    if (state is AdminUsersLoaded) {
      return RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: _buildUserList(context, state.users),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildUserList(BuildContext context, List<User> users) {
    if (users.isEmpty) {
      return ListView(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.35,
            child: EmptyState(
              icon: Icons.people_outline_rounded,
              message: context.tr('adminUsersPage.noUsersFound'),
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(kPaddingMedium),
      itemCount: users.length,
      separatorBuilder: (_, _) => const SizedBox(height: kPaddingSmall),
      itemBuilder: (context, index) => _buildUserTile(context, users[index]),
    );
  }

  Widget _buildUserTile(BuildContext context, User user) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final roleLabel = context.tr('userRole.${user.role.name}');

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: colors.primaryContainer,
          foregroundColor: colors.primary,
          backgroundImage: user.profileImageUrl == null
              ? null
              : NetworkImage(user.profileImageUrl!),
          child: user.profileImageUrl == null
              ? Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        title: Text(
          user.name,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${user.email} • $roleLabel',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: colors.outline),
        onTap: () => _onUserTapped(context, user),
      ),
    );
  }

  void _onSearchChanged(String query) {
    context.read<AdminUsersBloc>().add(AdminUsersSearchChanged(query));
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<AdminUsersBloc>().add(const AdminUsersRefreshed());
    await context.read<AdminUsersBloc>().stream.firstWhere(
      (state) => state is! AdminUsersLoading,
    );
  }

  void _onUserTapped(BuildContext context, User user) {
    context.push(AdminRoutes.userHistoryPath(user.id), extra: user);
  }

  void _onStateChanged(BuildContext context, AdminUsersState state) {
    if (state is AdminUsersFailure) {
      GlobalErrorHandler().handleError(context, state.failure);
    }
  }
}

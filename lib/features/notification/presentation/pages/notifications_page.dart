import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/features/notification/domain/entities/notification.dart';
import 'package:app_starter_kit_bloc/features/notification/presentation/bloc/notifications_bloc.dart';
import 'package:app_starter_kit_bloc/features/notification/presentation/pages/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final bloc = context.read<NotificationsBloc>();
    final state = bloc.state;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !state.isLoadingMore &&
        state.hasMore &&
        !state.isLoading) {
      bloc.add(const NotificationsEvent.loadMore());
    }
  }

  void _onFailure(BuildContext context, NotificationsState state) {
    if (state.failure != null) {
      GlobalErrorHandler().handleError(context, state.failure!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<NotificationsBloc, NotificationsState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure && current.failure != null,
      listener: _onFailure,
      child: _buildScaffold(context, theme),
    );
  }

  Widget _buildScaffold(BuildContext context, ThemeData theme) {
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: _buildBody(context, theme),
    );
  }

  Widget _buildBody(BuildContext context, ThemeData theme) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<NotificationsBloc>().add(
              const NotificationsEvent.refresh(),
            );
          },
          child: _buildScrollView(context, theme, state),
        );
      },
    );
  }

  Widget _buildScrollView(
    BuildContext context,
    ThemeData theme,
    NotificationsState state,
  ) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        _buildSilverAppBar(context, theme),
        SliverToBoxAdapter(child: _buildTypeFilter(context, state)),
        _buildSilverBody(state),
        if (state.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }

  Widget _buildSilverAppBar(BuildContext context, ThemeData theme) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      title: Text(
        context.tr('notificationPage.notifications'),
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTypeFilter(BuildContext context, NotificationsState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Wrap(
        spacing: 8,
        children: NotificationType.values.map((type) {
          final selected = state.type == type;
          return FilterChip(
            label: Text(_typeLabel(type)),
            selected: selected,
            onSelected: (_) {
              context.read<NotificationsBloc>().add(
                NotificationsEvent.typeChanged(type),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSilverBody(NotificationsState state) {
    if (state.isLoading && state.notifications.isEmpty) {
      return _buildSilverLoading();
    }

    if (state.failure != null &&
        state.notifications.isEmpty &&
        !state.isLoading) {
      return _buildSilverError(state);
    }

    if (state.notifications.isEmpty) {
      return _buildSilverEmpty();
    }

    return _buildSilverList(state);
  }

  Widget _buildSilverLoading() {
    return SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildSilverError(NotificationsState state) {
    return SliverFillRemaining(
      child: _ErrorView(
        onRetry: () => context.read<NotificationsBloc>().add(
          const NotificationsEvent.fetchNotifications(),
        ),
      ),
    );
  }

  Widget _buildSilverEmpty() {
    return const SliverFillRemaining(child: _EmptyView());
  }

  Widget _buildSilverList(NotificationsState state) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: state.notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notification = state.notifications[index];
          return NotificationCard(notification: notification);
        },
      ),
    );
  }

  String _typeLabel(NotificationType type) => switch (type) {
    NotificationType.activity => 'Activity',
    NotificationType.offer => 'Offers',
    NotificationType.announcement => 'Announcements',
  };
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            context.tr('notificationPage.noNotificationsYet'),
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 16),
            Text(
              context.tr('notificationPage.couldNotLoadNotifications'),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(context.tr('notificationPage.retry')),
            ),
          ],
        ),
      ),
    );
  }
}

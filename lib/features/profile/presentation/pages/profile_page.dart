import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          current is ProfileFailure && previous is! ProfileFailure,
      listener: (context, state) {
        if (state is ProfileFailure) {
          GlobalErrorHandler().handleError(context, state.failure);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.tr('profilePage.title'))),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileEmpty) {
              return Center(
                child: Text(context.tr('profilePage.noStoredUser')),
              );
            }
            if (state is ProfileLoaded) {
              return _ProfileBody(user: state.user);
            }
            if (state is ProfileFailure) {
              return Center(child: Text(context.tr('profilePage.loadError')));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = user.image.trim();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildUserAvatar(context, theme, imageUrl),
        const SizedBox(height: 24),
        Text(
          '${user.firstName} ${user.lastName}'.trim(),
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildUsername(context, theme, user.username),
        const SizedBox(height: 8),
        _buildEmail(context, theme, user.email),
        const SizedBox(height: 8),
        _buildGender(context, theme, user.gender),
        const SizedBox(height: 32),
        _buildLogoutButton(context, theme),
      ],
    );
  }

  Widget _buildUserAvatar(
    BuildContext context,
    ThemeData theme,
    String imageUrl,
  ) {
    return Center(
      child: CircleAvatar(
        radius: 48,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
        child: imageUrl.isEmpty
            ? Icon(
                Icons.person,
                size: 48,
                color: theme.colorScheme.onSurfaceVariant,
              )
            : null,
      ),
    );
  }

  Widget _buildUsername(
    BuildContext context,
    ThemeData theme,
    String username,
  ) {
    return Text(
      username,
      textAlign: TextAlign.center,
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildEmail(BuildContext context, ThemeData theme, String email) {
    return Text(
      email,
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyLarge,
    );
  }

  Widget _buildGender(BuildContext context, ThemeData theme, String gender) {
    return Text(
      '${context.tr('profilePage.gender')}: $gender',
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ThemeData theme) {
    return FilledButton.icon(
      onPressed: () {
        context.read<AuthBloc>().add(LogoutRequested());
      },
      icon: const Icon(Icons.logout),
      label: Text(context.tr('profilePage.logout')),
    );
  }
}

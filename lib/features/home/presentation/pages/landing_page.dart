import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/features/auth/auth_routes.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/widgets/language_selector.dart';
import 'package:app_starter_kit_bloc/shared/utils/extensions/string_extensions.dart';
import 'package:app_starter_kit_bloc/shared/widgets/change_theme_icon_button.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildAppLogo(theme),
                      const SizedBox(height: 16),
                      _buildBrandName(theme, context.tr('landingPage.appName')),
                      const SizedBox(height: 8),
                      _buildBrandMessage(theme, context.tr('landingPage.welcome')),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildLoginButton(theme, context.tr('landingPage.login')),
                  const SizedBox(height: 16),
                  _buildRegisterButton(theme, context.tr('landingPage.register')),
                  const SizedBox(height: 32), // Bottom padding
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(actions: [const ChangeThemeIconButton(), const LanguageSelector()]);
  }

  Widget _buildAppLogo(ThemeData theme) {
    return SizedBox.square(
      dimension: 192,
      child: Image.asset('app_logo.png'.toAssetImagePath, fit: BoxFit.contain),
    );
  }

  Widget _buildBrandName(ThemeData theme, String name) {
    return Text(
      name,
      style: theme.textTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildBrandMessage(ThemeData theme, String message) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w300),
    );
  }

  Widget _buildLoginButton(ThemeData theme, String label) {
    return ElevatedButton(
      onPressed: _navigateToLogin,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        textStyle: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(label),
    );
  }

  Widget _buildRegisterButton(ThemeData theme, String label) {
    return ElevatedButton(
      onPressed: _navigateToRegister,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.secondaryContainer,
        foregroundColor: theme.colorScheme.onSecondaryContainer,
        textStyle: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(label),
    );
  }

  void _navigateToLogin() {
    serviceLocator.get<AppRouter>().navigateToLogin();
  }

  void _navigateToRegister() {
    ScaffoldMessenger.of(AppNavigatorKey.context).showSnackBar(
      const SnackBar(
        content: Text('New user registration is not available yet'),
      ),
    );
  }
}

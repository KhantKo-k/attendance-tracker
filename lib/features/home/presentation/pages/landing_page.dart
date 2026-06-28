import 'package:attendance_tracker/core/di/service_locator.dart';
import 'package:attendance_tracker/core/navigation/app_router.dart';
import 'package:attendance_tracker/features/auth/auth_routes.dart';
import 'package:attendance_tracker/features/localization/presentation/extensions/localization_extension.dart';
import 'package:attendance_tracker/shared/theme/dimensions.dart';
import 'package:attendance_tracker/shared/utils/extensions/string_extensions.dart';
import 'package:attendance_tracker/shared/widgets/app_bar_settings_actions.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeroSection(context, theme, colors),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLoginButton(context, theme),
                    const SizedBox(height: kPaddingMedium),
                    _buildRegisterButton(context, theme),
                    const SizedBox(height: kPaddingXLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: const [AppBarSettingsActions()],
    );
  }

  Widget _buildHeroSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colors,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        kPaddingLarge,
        kPaddingMedium,
        kPaddingLarge,
        kPaddingXLarge,
      ),
      child: Column(
        children: [
          _buildAppLogo(colors),
          const SizedBox(height: kPaddingLarge),
          _buildBrandName(theme, context.tr('landingPage.appName')),
          const SizedBox(height: kPaddingSmall),
          _buildBrandMessage(theme, context.tr('landingPage.welcome')),
        ],
      ),
    );
  }

  Widget _buildAppLogo(ColorScheme colors) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(kPaddingMedium),
      child: Image.asset(
        'app_logo.png'.toAssetImagePath,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildBrandName(ThemeData theme, String name) {
    return Text(
      name,
      textAlign: TextAlign.center,
      style: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildBrandMessage(ThemeData theme, String message) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        height: 1.5,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, ThemeData theme) {
    return FilledButton(
      onPressed: _navigateToLogin,
      child: Text(context.tr('landingPage.login')),
    );
  }

  Widget _buildRegisterButton(BuildContext context, ThemeData theme) {
    return OutlinedButton(
      onPressed: _navigateToRegister,
      child: Text(context.tr('landingPage.register')),
    );
  }

  void _navigateToLogin() {
    serviceLocator.get<AppRouter>().navigateToLogin();
  }

  void _navigateToRegister() {
    serviceLocator.get<AppRouter>().navigateToRegister();
  }
}

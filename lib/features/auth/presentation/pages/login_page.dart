import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/home/presentation/home_routes.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/widgets/language_selector.dart';
import 'package:app_starter_kit_bloc/shared/theme/dimensions.dart';
import 'package:app_starter_kit_bloc/shared/utils/extensions/string_extensions.dart';
import 'package:app_starter_kit_bloc/shared/widgets/change_theme_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginFail) {
          _handleLoginFailure(context, state);
          return;
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.select(
            (AuthBloc bloc) => bloc.state is LoginLoading,
          );

          return PopScope(
            canPop: !isLoading,
            child: Scaffold(
              appBar: _buildAppBar(context.tr('loginPage.login')),
              body: _buildLoginForm(),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(String title) {
    return AppBar(
      leading: BackButton(onPressed: () => context.go(HomeRoutes.landing)),
      title: Text(title),
      actions: [const ChangeThemeIconButton(), const LanguageSelector()],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(kPaddingMedium),
          child: Column(
            children: [
              _buildAppLogo(),
              const SizedBox(height: 16),
              _buildWelcomeMessage(context.tr('loginPage.welcome')),
              const SizedBox(height: 32),
              _buildInputFields(),
              const SizedBox(height: 24),
              _buildLoginButton(context.tr('loginPage.login')),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      width: 156,
      height: 156,
      padding: EdgeInsets.all(kPaddingSmall),
      child: Image.asset('app_logo.png'.toAssetImagePath, fit: BoxFit.contain),
    );
  }

  Widget _buildWelcomeMessage(String welcomeMessage) {
    return Text(
      welcomeMessage,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInputFields() {
    return Builder(
      builder: (context) {
        final isLoading = context.select(
          (AuthBloc bloc) => bloc.state is LoginLoading,
        );

        return AutofillGroup(
          child: Column(
            children: [
              _buildUserNameInput(
                isLoading,
                context.tr('loginPage.username'),
                context.tr('loginPage.usernameRequired'),
              ),
              const SizedBox(height: 16),
              _buildPasswordInput(
                isLoading,
                context.tr('loginPage.password'),
                context.tr('loginPage.passwordRequired'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserNameInput(
    bool isLoading,
    String usernameLabel,
    String usernameRequiredMessage,
  ) {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: usernameLabel,
        prefixIcon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return usernameRequiredMessage;
        }
        return null;
      },
      enabled: !isLoading,
      keyboardType: TextInputType.emailAddress,
      autofillHints: [AutofillHints.email, AutofillHints.username],
      // onFieldSubmitted: (_) => TextInput.finishAutofillContext(),
    );
  }

  Widget _buildPasswordInput(
    bool isLoading,
    String passwordLabel,
    String passwordRequiredMessage,
  ) {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: passwordLabel,
        prefixIcon: Icon(Icons.lock),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return passwordRequiredMessage;
        }
        return null;
      },
      onFieldSubmitted: (_) => _loginClicked(),
      enabled: !isLoading,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: [AutofillHints.password],
    );
  }

  Widget _buildLoginButton(String loginButtonText) {
    return Builder(
      builder: (context) {
        final isLoading = context.select(
          (AuthBloc bloc) => bloc.state is LoginLoading,
        );

        final theme = Theme.of(context);

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _loginClicked,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              textStyle: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(loginButtonText),
          ),
        );
      },
    );
  }

  void _loginClicked() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
      LoginRequested(
        userName: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _handleLoginFailure(BuildContext context, LoginFail state) {
    GlobalErrorHandler().handleError(context, state.failure);
  }
}

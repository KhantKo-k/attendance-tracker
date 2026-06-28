import 'package:attendance_tracker/core/error/global_error_handler.dart';
import 'package:attendance_tracker/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:attendance_tracker/features/home/presentation/home_routes.dart';
import 'package:attendance_tracker/features/localization/presentation/extensions/localization_extension.dart';
import 'package:attendance_tracker/shared/theme/dimensions.dart';
import 'package:attendance_tracker/shared/utils/extensions/string_extensions.dart';
import 'package:attendance_tracker/shared/widgets/app_card.dart';
import 'package:attendance_tracker/shared/widgets/app_bar_settings_actions.dart';
import 'package:attendance_tracker/shared/widgets/password_text_field.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _onStateChanged,
      child: Builder(
        builder: (context) {
          final isLoading = context.select(
            (AuthBloc bloc) => bloc.state is AuthLoading,
          );

          return PopScope(
            canPop: !isLoading,
            child: Scaffold(
              appBar: _buildAppBar(context),
              body: _buildLoginForm(context, isLoading),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: BackButton(onPressed: () => context.go(HomeRoutes.landing)),
      title: Text(context.tr('loginPage.title')),
      actions: const [AppBarSettingsActions()],
    );
  }

  Widget _buildLoginForm(BuildContext context, bool isLoading) {
    return Center(
      child: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(kPaddingLarge),
        child: Form(
          key: _formKey,
          child: AppCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAppLogo(),
                const SizedBox(height: kPaddingLarge),
                _buildEmailInput(context, isLoading),
                const SizedBox(height: kPaddingMedium),
                _buildPasswordInput(context, isLoading),
                const SizedBox(height: kPaddingLarge),
                _buildLoginButton(context, isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return SizedBox(
      width: 96,
      height: 96,
      child: Image.asset('app_logo.png'.toAssetImagePath, fit: BoxFit.contain),
    );
  }

  Widget _buildEmailInput(BuildContext context, bool isLoading) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: context.tr('loginPage.email'),
        prefixIcon: const Icon(Icons.email_outlined),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return context.trRead('loginPage.emailRequired');
        }
        return null;
      },
      enabled: !isLoading,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordInput(BuildContext context, bool isLoading) {
    return PasswordTextField(
      controller: _passwordController,
      labelText: context.tr('loginPage.password'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.trRead('loginPage.passwordRequired');
        }
        return null;
      },
      onFieldSubmitted: (_) => _loginClicked(),
      enabled: !isLoading,
    );
  }

  Widget _buildLoginButton(BuildContext context, bool isLoading) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : _loginClicked,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(context.tr('loginPage.login')),
      ),
    );
  }

  void _loginClicked() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
      LoginRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  void _onStateChanged(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      GlobalErrorHandler().handleError(context, state.failure);
    }
  }
}

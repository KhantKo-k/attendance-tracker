import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/home/presentation/home_routes.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/shared/theme/dimensions.dart';
import 'package:app_starter_kit_bloc/shared/widgets/app_bar_settings_actions.dart';
import 'package:app_starter_kit_bloc/shared/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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

          return Scaffold(
            appBar: _buildAppBar(context),
            body: _buildForm(context, isLoading),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: BackButton(onPressed: () => context.go(HomeRoutes.landing)),
      title: Text(context.tr('registerPage.title')),
      actions: const [AppBarSettingsActions()],
    );
  }

  Widget _buildForm(BuildContext context, bool isLoading) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(kPaddingLarge),
        children: [
          AppCard(
            child: Column(
              children: [
                _buildNameInput(context, isLoading),
                const SizedBox(height: kPaddingMedium),
                _buildEmailInput(context, isLoading),
                const SizedBox(height: kPaddingMedium),
                _buildPasswordInput(context, isLoading),
                const SizedBox(height: kPaddingLarge),
                _buildRegisterButton(context, isLoading),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameInput(BuildContext context, bool isLoading) {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: context.tr('registerPage.fullName'),
        prefixIcon: const Icon(Icons.person_outline),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return context.tr('registerPage.nameRequired');
        }
        return null;
      },
      enabled: !isLoading,
    );
  }

  Widget _buildEmailInput(BuildContext context, bool isLoading) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: context.tr('registerPage.email'),
        prefixIcon: const Icon(Icons.email_outlined),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return context.tr('registerPage.emailRequired');
        }
        return null;
      },
      enabled: !isLoading,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordInput(BuildContext context, bool isLoading) {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: context.tr('registerPage.password'),
        prefixIcon: const Icon(Icons.lock_outline),
      ),
      validator: (value) {
        if (value == null || value.length < 6) {
          return context.tr('registerPage.passwordMinLength');
        }
        return null;
      },
      enabled: !isLoading,
      obscureText: true,
    );
  }

  Widget _buildRegisterButton(BuildContext context, bool isLoading) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : _registerClicked,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(context.tr('registerPage.createAccount')),
      ),
    );
  }

  void _registerClicked() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
      RegisterRequested(
        name: _nameController.text.trim(),
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

import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/core/security/bloc/app_security_guard_bloc.dart';
import 'package:app_starter_kit_bloc/core/security/talsec_service.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/services/localization_service.dart';
import 'package:app_starter_kit_bloc/shared/theme/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppThemeCubit()),
        BlocProvider(create: (context) => serviceLocator.get<AuthBloc>()),
        BlocProvider(
          create: (context) =>
              serviceLocator.get<AppSecurityGuardBloc>()
                ..add(StartSecurityGuard()),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => serviceLocator.get<LocalizationService>(),
        child: const _AppView(),
      ),
      // child: Builder(
      //   builder: (context) {
      //     return MaterialApp.router(
      //       routerConfig: serviceLocator.get<AppRouter>().router,
      //       debugShowCheckedModeBanner: false,
      //       theme: context.watch<AppThemeCubit>().state,
      //       builder: (context, child) {
      //         return BlocListener<AppSecurityGuardBloc, AppSecurityGuardState>(
      //           listener: (context, state) {
      //             if (state is AppSecurityGuardError) {
      //               _handleSecurityIssue(context, state.issue);
      //             }
      //           },
      //           child: child,
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final localizationService = context.watch<LocalizationService>();

    return MaterialApp.router(
      routerConfig: serviceLocator.get<AppRouter>().router,
      debugShowCheckedModeBanner: false,
      theme: context.watch<AppThemeCubit>().state,
      locale: localizationService.currentLocale,
      builder: (context, child) {
        return BlocListener<AppSecurityGuardBloc, AppSecurityGuardState>(
          listener: (context, state) {
            if (state is AppSecurityGuardError) {
              _handleSecurityIssue(context, state.issue);
            }
          },
          child: child,
        );
      },
    );
  }

  void _handleSecurityIssue(
    BuildContext context,
    AppSecurityIssue issue,
  ) async {
    // GlobalErrorHandler
  }
}

import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app_starter_kit_bloc/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileRoutes {
  static const profile = '/profile';

  static final routes = <GoRoute>[
    GoRoute(
      path: profile,
      builder: (context, state) => BlocProvider(
        create: (_) => serviceLocator.get<ProfileCubit>(),
        child: const ProfilePage(),
      ),
    ),
  ];
}

extension ProfileRoutesExtension on AppRouter {
  void goToProfile(BuildContext context) {
    context.push(ProfileRoutes.profile);
  }
}


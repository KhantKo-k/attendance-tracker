import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/features/experiment/presentation/blocs/mock_bloc.dart';
import 'package:app_starter_kit_bloc/features/experiment/presentation/pages/experiment_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExperimentRoutes {
  static const experiment = '/experiment';

  static final shellRoutes = [
    GoRoute( 
      path: experiment,
      builder: (context, state)  {
        return BlocProvider( 
          create: (context) => serviceLocator<MockBloc>(),
          child: const ExperimentPage(),
        );
      }
    )
  ];
}
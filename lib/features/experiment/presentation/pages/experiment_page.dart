import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/experiment/presentation/blocs/mock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExperimentPage extends StatelessWidget {
  const ExperimentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody(context));
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text('Experiment'));
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: BlocConsumer<MockBloc, MockState>(
        listener: (context, state) {
          if (state is MockError) {
            _showErrorDialog(context, state.failure);
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStateStatus(state),
              const SizedBox(height: 32),
              _buildActionButtons(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStateStatus(MockState state) {
    if (state is MockLoaded) {
      return Column(
        children: [
          const Icon(Icons.verified_user, color: Colors.blue, size: 48),
          Text("Loaded: ${state.mockModel.username}"),
        ],
      );
    } else if (state is MockLoading) {
      return const CircularProgressIndicator();
    }
    return const Text("Press the button to load data");
  }

  Widget _buildActionButtons(BuildContext context, MockState state) {
    final bool isLoading = state is MockLoading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () => context.read<MockBloc>().add(MockRequest()),
              child: const Text("Load Data"),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, Failure failure) async {

    GlobalErrorHandler().handleError(context, failure);
    // final interpretation = failure.interpretation;
    // final retry = await CommonDialog.showConfirmDialog(
    //   context: context,
    //   title: interpretation.title,
    //   message: interpretation.message,
    //   confirmText: 'retry',
    //   cancelText: 'cancel',
    // );
    // if (!context.mounted) return;
    // if (retry) {
    //   context.read<MockBloc>().add(MockRequest());
    // } else {
    //   // AppRouter.navigateToHome();
    // }
  }

}

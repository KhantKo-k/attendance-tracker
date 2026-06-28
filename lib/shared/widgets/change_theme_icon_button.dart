import 'package:attendance_tracker/shared/theme/app_theme.dart';
import 'package:attendance_tracker/shared/theme/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeThemeIconButton extends StatelessWidget {
  const ChangeThemeIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return IconButton(
          onPressed: () {
            context.read<AppThemeCubit>().toggleTheme();
          },
          icon: Icon(
            context.select(
              (AppThemeCubit cubit) => cubit.state == AppTheme.lightTheme
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        );
      },
    );
  }
}

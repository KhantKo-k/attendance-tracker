import 'package:app_starter_kit_bloc/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeCubit extends Cubit<ThemeData> {
  AppThemeCubit() : super(AppTheme.lightTheme);

  void toggleTheme() {
    emit(
      state == AppTheme.lightTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
    );
  }
}

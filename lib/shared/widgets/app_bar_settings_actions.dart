import 'package:attendance_tracker/features/localization/presentation/widgets/language_selector.dart';
import 'package:attendance_tracker/shared/widgets/change_theme_icon_button.dart';
import 'package:flutter/material.dart';

class AppBarSettingsActions extends StatelessWidget {
  const AppBarSettingsActions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ChangeThemeIconButton(),
        LanguageSelector(),
      ],
    );
  }
}

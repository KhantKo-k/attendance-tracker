import 'package:app_starter_kit_bloc/features/localization/presentation/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<Locale> supportedLocales = const [Locale('en'), Locale('my')];

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = context.watch<LocalizationService>();

    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language), // 🌐 globe icon
      onSelected: (Locale locale) async {
        await localizationService.changeLocale(locale);
      },
      itemBuilder: (context) {
        return supportedLocales.map((locale) {
          final isSelected =
              locale.languageCode ==
              localizationService.currentLocale.languageCode;

          return PopupMenuItem(
            value: locale,
            child: Row(
              children: [
                Text(
                  _getLanguageShortName(locale.languageCode),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 8),
                if (isSelected) const Icon(Icons.check, size: 16),
              ],
            ),
          );
        }).toList();
      },
    );
  }

  String _getLanguageShortName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'my':
        return 'မြန်မာ';
      default:
        return code.toUpperCase();
    }
  }
}

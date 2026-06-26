import 'package:app_starter_kit_bloc/shared/theme/app_colors.dart';
import 'package:app_starter_kit_bloc/shared/theme/dimensions.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = _buildLightTheme();

  static ThemeData darkTheme = _buildDarkTheme();

  static ThemeData _buildLightTheme() {
    return _buildTheme(AppColors.lightScheme());
  }

  static ThemeData _buildDarkTheme() {
    return _buildTheme(AppColors.darkScheme());
  }

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
    );

    final textTheme = _createTextTheme(base);

    return base.copyWith(
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      appBarTheme: AppBarTheme(centerTitle: true),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) => Icon(Icons.arrow_back),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: kBorderRadius),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
          minimumSize: const Size(double.infinity, kButtonHeight),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface,
      ),
    );
  }

  static TextTheme _createTextTheme(ThemeData base) {
    TextTheme baseTextTheme = base.textTheme;

    return baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge!.copyWith(
        fontFamily: "Raleway",
        fontSize: 57,
      ),
      displayMedium: baseTextTheme.displayMedium!.copyWith(
        fontFamily: "Raleway",
        fontSize: 52,
      ),
      displaySmall: baseTextTheme.displaySmall!.copyWith(
        fontFamily: "Raleway",
        fontSize: 44,
      ),
      headlineLarge: baseTextTheme.headlineLarge!.copyWith(
        fontFamily: "Raleway",
        fontSize: 32,
      ),
      headlineMedium: baseTextTheme.headlineMedium!.copyWith(
        fontFamily: "Raleway",
        fontSize: 28,
      ),
      headlineSmall: baseTextTheme.headlineSmall!.copyWith(
        fontFamily: "Raleway",
        fontSize: 24,
      ),
      titleLarge: baseTextTheme.titleLarge!.copyWith(
        fontFamily: "Raleway",
        fontSize: 22,
      ),
      titleMedium: baseTextTheme.titleMedium!.copyWith(
        fontFamily: "Raleway",
        fontSize: 16,
      ),
      titleSmall: baseTextTheme.titleSmall!.copyWith(
        fontFamily: "Raleway",
        fontSize: 14,
      ),
      bodyLarge: baseTextTheme.bodyLarge!.copyWith(
        fontFamily: "Nunito",
        fontSize: 16,
      ),
      bodyMedium: baseTextTheme.bodyMedium!.copyWith(
        fontFamily: "Nunito",
        fontSize: 14,
      ),
      bodySmall: baseTextTheme.bodySmall!.copyWith(
        fontFamily: "Nunito",
        fontSize: 12,
      ),
      labelLarge: baseTextTheme.labelLarge!.copyWith(
        fontFamily: "Nunito",
        fontSize: 14,
      ),
      labelMedium: baseTextTheme.labelMedium!.copyWith(
        fontFamily: "Nunito",
        fontSize: 12,
      ),
      labelSmall: baseTextTheme.labelSmall!.copyWith(
        fontFamily: "Nunito",
        fontSize: 11,
      ),
    );
  }
}

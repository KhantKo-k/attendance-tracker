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
      scaffoldBackgroundColor: colorScheme.surface,
    );

    final textTheme = _createTextTheme(base);

    return base.copyWith(
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) =>
            const Icon(Icons.arrow_back_rounded),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: kBorderRadius,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: kPaddingMedium,
          vertical: kPaddingMedium,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
          minimumSize: const Size(double.infinity, kButtonHeight),
          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
          minimumSize: const Size(double.infinity, kButtonHeight),
          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
          minimumSize: const Size(double.infinity, kButtonHeight),
          side: BorderSide(color: colorScheme.outline),
          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 72,
        backgroundColor: colorScheme.surfaceContainerLowest,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelMedium?.copyWith(
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          );
        }),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
        side: BorderSide.none,
        backgroundColor: colorScheme.tertiaryContainer,
        labelStyle: textTheme.labelMedium?.copyWith(
          color: colorScheme.onTertiaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: kPaddingMedium,
          vertical: kPaddingSmall,
        ),
      ),
    );
  }

  static TextTheme _createTextTheme(ThemeData base) {
    TextTheme baseTextTheme = base.textTheme;

    return baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge!.copyWith(
        fontFamily: 'Raleway',
        fontSize: 57,
      ),
      displayMedium: baseTextTheme.displayMedium!.copyWith(
        fontFamily: 'Raleway',
        fontSize: 52,
      ),
      displaySmall: baseTextTheme.displaySmall!.copyWith(
        fontFamily: 'Raleway',
        fontSize: 44,
      ),
      headlineLarge: baseTextTheme.headlineLarge!.copyWith(
        fontFamily: 'Raleway',
        fontSize: 32,
      ),
      headlineMedium: baseTextTheme.headlineMedium!.copyWith(
        fontFamily: 'Raleway',
        fontSize: 28,
      ),
      headlineSmall: baseTextTheme.headlineSmall!.copyWith(
        fontFamily: 'Raleway',
        fontSize: 24,
      ),
      titleLarge: baseTextTheme.titleLarge!.copyWith(
        fontFamily: 'Raleway',
        fontSize: 22,
      ),
      titleMedium: baseTextTheme.titleMedium!.copyWith(
        fontFamily: 'Raleway',
        fontSize: 16,
      ),
      titleSmall: baseTextTheme.titleSmall!.copyWith(
        fontFamily: 'Raleway',
        fontSize: 14,
      ),
      bodyLarge: baseTextTheme.bodyLarge!.copyWith(
        fontFamily: 'Nunito',
        fontSize: 16,
      ),
      bodyMedium: baseTextTheme.bodyMedium!.copyWith(
        fontFamily: 'Nunito',
        fontSize: 14,
      ),
      bodySmall: baseTextTheme.bodySmall!.copyWith(
        fontFamily: 'Nunito',
        fontSize: 12,
      ),
      labelLarge: baseTextTheme.labelLarge!.copyWith(
        fontFamily: 'Nunito',
        fontSize: 14,
      ),
      labelMedium: baseTextTheme.labelMedium!.copyWith(
        fontFamily: 'Nunito',
        fontSize: 12,
      ),
      labelSmall: baseTextTheme.labelSmall!.copyWith(
        fontFamily: 'Nunito',
        fontSize: 11,
      ),
    );
  }
}

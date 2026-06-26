import 'package:flutter/material.dart';

class AppColors {
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff116682),
      surfaceTint: Color(0xff116682),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbde9ff),
      onPrimaryContainer: Color(0xff004d64),
      secondary: Color(0xff4d616c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd0e6f2),
      onSecondaryContainer: Color(0xff354a53),
      tertiary: Color(0xff5d5b7d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe3dfff),
      onTertiaryContainer: Color(0xff454364),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff6fafd),
      onSurface: Color(0xff171c1f),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787d),
      outlineVariant: Color(0xffc0c8cd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff8bd0ef),
      primaryFixed: Color(0xffbde9ff),
      onPrimaryFixed: Color(0xff001f2a),
      primaryFixedDim: Color(0xff8bd0ef),
      onPrimaryFixedVariant: Color(0xff004d64),
      secondaryFixed: Color(0xffd0e6f2),
      onSecondaryFixed: Color(0xff081e27),
      secondaryFixedDim: Color(0xffb4cad6),
      onSecondaryFixedVariant: Color(0xff354a53),
      tertiaryFixed: Color(0xffe3dfff),
      onTertiaryFixed: Color(0xff191836),
      tertiaryFixedDim: Color(0xffc6c2ea),
      onTertiaryFixedVariant: Color(0xff454364),
      surfaceDim: Color(0xffd6dbde),
      surfaceBright: Color(0xfff6fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffeaeef2),
      surfaceContainerHigh: Color(0xffe4e9ec),
      surfaceContainerHighest: Color(0xffdfe3e7),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8bd0ef),
      surfaceTint: Color(0xff8bd0ef),
      onPrimary: Color(0xff003546),
      primaryContainer: Color(0xff004d64),
      onPrimaryContainer: Color(0xffbde9ff),
      secondary: Color(0xffb4cad6),
      onSecondary: Color(0xff1f333c),
      secondaryContainer: Color(0xff354a53),
      onSecondaryContainer: Color(0xffd0e6f2),
      tertiary: Color(0xffc6c2ea),
      onTertiary: Color(0xff2e2d4d),
      tertiaryContainer: Color(0xff454364),
      onTertiaryContainer: Color(0xffe3dfff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffdfe3e7),
      onSurfaceVariant: Color(0xffc0c8cd),
      outline: Color(0xff8a9297),
      outlineVariant: Color(0xff40484c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe3e7),
      inversePrimary: Color(0xff116682),
      primaryFixed: Color(0xffbde9ff),
      onPrimaryFixed: Color(0xff001f2a),
      primaryFixedDim: Color(0xff8bd0ef),
      onPrimaryFixedVariant: Color(0xff004d64),
      secondaryFixed: Color(0xffd0e6f2),
      onSecondaryFixed: Color(0xff081e27),
      secondaryFixedDim: Color(0xffb4cad6),
      onSecondaryFixedVariant: Color(0xff354a53),
      tertiaryFixed: Color(0xffe3dfff),
      onTertiaryFixed: Color(0xff191836),
      tertiaryFixedDim: Color(0xffc6c2ea),
      onTertiaryFixedVariant: Color(0xff454364),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f11),
      surfaceContainerLow: Color(0xff171c1f),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff262b2d),
      surfaceContainerHighest: Color(0xff303538),
    );
  }

  static const primary = Color(0xffFFE512);
  static const secondary = Color(0xff019CDF);
  static const onPrimary = secondary;
  static const onSecondary = Color(0xffffffff);
  static const accent = Color(0xffEFCC03);

  static const surface = Color(0xffffffff);

  static const primaryText = Color(0xff000000);
  static const secondaryText = Color(0xff585858);
  static const hintText = Color(0xff9d9d9d);
  static const highLightText = Color(0xff67308F);
  static const error = Color(0xffDD2828);
  static const success = Color(0xff14B464);

  static const disabled = Color(0xffcccccc);
  static const onDisabled = Color(0xffffffff);

  static const formFieldLabel = Color(0xff585858);
  static const formFieldHint = Color(0xff9d9d9d);
  static const formFieldError = Color(0xffDD2828);
  static const formFieldBackground = Color(0xffffffff);
  static const formFieldDisabledBackground = Color(0xffF4F6F8);
  static const formFieldBorder = Color(0xffcccccc);
  static const floatingMenuBackground = Color(0xffFEFEE8);

  static const divider = Color(0xffCCCCCC);
  static const outline = Color(0xffCCCCCC);
}

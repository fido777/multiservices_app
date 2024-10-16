import "package:flutter/material.dart";

class MaterialTheme {
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff50C2C9),
      surfaceTint: Color(0xff00696e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9cf0f6),
      onPrimaryContainer: Color(0xff002022),
      secondary: Color(0xff4a6364),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcce8e9),
      onSecondaryContainer: Color(0xff041f21),
      tertiary: Color(0xff4e5f7d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd6e3ff),
      onTertiaryContainer: Color(0xff081c36),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff4fafa),
      onSurface: Color(0xff161d1d),
      onSurfaceVariant: Color(0xff3f4949),
      outline: Color(0xff6f7979),
      outlineVariant: Color(0xffbec8c9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3232),
      inversePrimary: Color(0xff80d4d9),
      primaryFixed: Color(0xff9cf0f6),
      onPrimaryFixed: Color(0xff002022),
      primaryFixedDim: Color(0xff80d4d9),
      onPrimaryFixedVariant: Color(0xff004f53),
      secondaryFixed: Color(0xffcce8e9),
      onSecondaryFixed: Color(0xff041f21),
      secondaryFixedDim: Color(0xffb1cccd),
      onSecondaryFixedVariant: Color(0xff324b4d),
      tertiaryFixed: Color(0xffd6e3ff),
      onTertiaryFixed: Color(0xff081c36),
      tertiaryFixedDim: Color(0xffb6c7e9),
      onTertiaryFixedVariant: Color(0xff364764),
      surfaceDim: Color(0xffd5dbdb),
      surfaceBright: Color(0xfff4fafa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f5),
      surfaceContainer: Color(0xffF1FDFE),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e4),
    );
  }

  static ThemeData light() {
    return ThemeData(
      fontFamily: 'Poppins',
      colorScheme: lightScheme(),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff80d4d9),
      surfaceTint: Color(0xff80d4d9),
      onPrimary: Color(0xff003739),
      primaryContainer: Color(0xff004f53),
      onPrimaryContainer: Color(0xff9cf0f6),
      secondary: Color(0xffb1cccd),
      onSecondary: Color(0xff1b3436),
      secondaryContainer: Color(0xff324b4d),
      onSecondaryContainer: Color(0xffcce8e9),
      tertiary: Color(0xffb6c7e9),
      onTertiary: Color(0xff20314c),
      tertiaryContainer: Color(0xff364764),
      onTertiaryContainer: Color(0xffd6e3ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdde4e4),
      onSurfaceVariant: Color(0xffbec8c9),
      outline: Color(0xff899393),
      outlineVariant: Color(0xff3f4949),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e4),
      inversePrimary: Color(0xff00696e),
      primaryFixed: Color(0xff9cf0f6),
      onPrimaryFixed: Color(0xff002022),
      primaryFixedDim: Color(0xff80d4d9),
      onPrimaryFixedVariant: Color(0xff004f53),
      secondaryFixed: Color(0xffcce8e9),
      onSecondaryFixed: Color(0xff041f21),
      secondaryFixedDim: Color(0xffb1cccd),
      onSecondaryFixedVariant: Color(0xff324b4d),
      tertiaryFixed: Color(0xffd6e3ff),
      onTertiaryFixed: Color(0xff081c36),
      tertiaryFixedDim: Color(0xffb6c7e9),
      onTertiaryFixedVariant: Color(0xff364764),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff303636),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      fontFamily: 'Poppins',
      colorScheme: darkScheme(),
    );
  }
}

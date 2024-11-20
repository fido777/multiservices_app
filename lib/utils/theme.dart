import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff47CFD6),
      surfaceTint: Color(0xff02969F),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff52d8df),
      onPrimaryContainer: Color(0xff003c3f),
      secondary: Color(0xff984627),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffff9771),
      onSecondaryContainer: Color(0xff4b1400),
      tertiary: Color(0xff65002c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9d1a4c),
      onTertiaryContainer: Color(0xfffff0f1),
      error: Color(0xff410a3b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff682e5e),
      onErrorContainer: Color(0xffffccef),
      surface: Color(0xfffbf9f8),
      onSurface: Color(0xff1b1c1c),
      onSurfaceVariant: Color(0xff3d494a),
      outline: Color(0xff6d797a),
      outlineVariant: Color(0xffbcc9ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303030),
      inversePrimary: Color(0xff53d9e0),
      primaryFixed: Color(0xff74f5fc),
      onPrimaryFixed: Color(0xff002021),
      primaryFixedDim: Color(0xff53d9e0),
      onPrimaryFixedVariant: Color(0xff004f53),
      secondaryFixed: Color(0xffffdbcf),
      onSecondaryFixed: Color(0xff380d00),
      secondaryFixedDim: Color(0xffffb59b),
      onSecondaryFixedVariant: Color(0xff7a3012),
      tertiaryFixed: Color(0xffffd9e0),
      onTertiaryFixed: Color(0xff3f0019),
      tertiaryFixedDim: Color(0xffffb1c3),
      onTertiaryFixedVariant: Color(0xff8d0741),
      surfaceDim: Color(0xffdbdad9),
      surfaceBright: Color(0xfffbf9f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f3f2),
      surfaceContainer: Color(0xffefeded),
      surfaceContainerHigh: Color(0xffe9e8e7),
      surfaceContainerHighest: Color(0xffe3e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004b4e),
      surfaceTint: Color(0xff00696e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff008287),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff752c0e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb45b3a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff65002c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9d1a4c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff410a3b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff682e5e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf9f8),
      onSurface: Color(0xff1b1c1c),
      onSurfaceVariant: Color(0xff394546),
      outline: Color(0xff556162),
      outlineVariant: Color(0xff717d7e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303030),
      inversePrimary: Color(0xff53d9e0),
      primaryFixed: Color(0xff008287),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00676b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffb45b3a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff954425),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffcc406e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xffab2656),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdbdad9),
      surfaceBright: Color(0xfffbf9f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f3f2),
      surfaceContainer: Color(0xffefeded),
      surfaceContainerHigh: Color(0xffe9e8e7),
      surfaceContainerHighest: Color(0xffe3e2e1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002729),
      surfaceTint: Color(0xff00696e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004b4e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff441100),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff752c0e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4b001f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff88013d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff410a3b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff682e5e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf9f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1a2627),
      outline: Color(0xff394546),
      outlineVariant: Color(0xff394546),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303030),
      inversePrimary: Color(0xffa6faff),
      primaryFixed: Color(0xff004b4e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003335),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff752c0e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff551800),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff88013d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5f0029),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdbdad9),
      surfaceBright: Color(0xfffbf9f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f3f2),
      surfaceContainer: Color(0xffefeded),
      surfaceContainerHigh: Color(0xffe9e8e7),
      surfaceContainerHighest: Color(0xffe3e2e1),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff71f3fa),
      surfaceTint: Color(0xff53d9e0),
      onPrimary: Color(0xff003739),
      primaryContainer: Color(0xff3dc8cf),
      onPrimaryContainer: Color(0xff003032),
      secondary: Color(0xffffbba3),
      onSecondary: Color(0xff5c1a00),
      secondaryContainer: Color(0xffec8763),
      onSecondaryContainer: Color(0xff2f0900),
      tertiary: Color(0xffffb1c3),
      onTertiary: Color(0xff66002c),
      tertiaryContainer: Color(0xff7a0036),
      onTertiaryContainer: Color(0xffffbcca),
      error: Color(0xfffaafe7),
      onError: Color(0xff511a49),
      errorContainer: Color(0xff4d1645),
      onErrorContainer: Color(0xffeca1d9),
      surface: Color(0xff121413),
      onSurface: Color(0xffe3e2e1),
      onSurfaceVariant: Color(0xffbcc9ca),
      outline: Color(0xff879394),
      outlineVariant: Color(0xff3d494a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e1),
      inversePrimary: Color(0xff00696e),
      primaryFixed: Color(0xff74f5fc),
      onPrimaryFixed: Color(0xff002021),
      primaryFixedDim: Color(0xff53d9e0),
      onPrimaryFixedVariant: Color(0xff004f53),
      secondaryFixed: Color(0xffffdbcf),
      onSecondaryFixed: Color(0xff380d00),
      secondaryFixedDim: Color(0xffffb59b),
      onSecondaryFixedVariant: Color(0xff7a3012),
      tertiaryFixed: Color(0xffffd9e0),
      onTertiaryFixed: Color(0xff3f0019),
      tertiaryFixedDim: Color(0xffffb1c3),
      onTertiaryFixedVariant: Color(0xff8d0741),
      surfaceDim: Color(0xff121413),
      surfaceBright: Color(0xff383939),
      surfaceContainerLowest: Color(0xff0d0e0e),
      surfaceContainerLow: Color(0xff1b1c1c),
      surfaceContainer: Color(0xff1f2020),
      surfaceContainerHigh: Color(0xff292a2a),
      surfaceContainerHighest: Color(0xff343535),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff71f3fa),
      surfaceTint: Color(0xff53d9e0),
      onPrimary: Color(0xff002d30),
      primaryContainer: Color(0xff3dc8cf),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffbba4),
      onSecondary: Color(0xff2f0900),
      secondaryContainer: Color(0xffec8763),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffb7c7),
      onTertiary: Color(0xff350014),
      tertiaryContainer: Color(0xfff05c8a),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffb3eb),
      onError: Color(0xff30002b),
      errorContainer: Color(0xffbf7aaf),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121413),
      onSurface: Color(0xfffcfafa),
      onSurfaceVariant: Color(0xffc0cdce),
      outline: Color(0xff99a5a6),
      outlineVariant: Color(0xff798586),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e1),
      inversePrimary: Color(0xff005054),
      primaryFixed: Color(0xff74f5fc),
      onPrimaryFixed: Color(0xff001415),
      primaryFixedDim: Color(0xff53d9e0),
      onPrimaryFixedVariant: Color(0xff003d40),
      secondaryFixed: Color(0xffffdbcf),
      onSecondaryFixed: Color(0xff270600),
      secondaryFixedDim: Color(0xffffb59b),
      onSecondaryFixedVariant: Color(0xff641f03),
      tertiaryFixed: Color(0xffffd9e0),
      onTertiaryFixed: Color(0xff2c000f),
      tertiaryFixedDim: Color(0xffffb1c3),
      onTertiaryFixedVariant: Color(0xff700031),
      surfaceDim: Color(0xff121413),
      surfaceBright: Color(0xff383939),
      surfaceContainerLowest: Color(0xff0d0e0e),
      surfaceContainerLow: Color(0xff1b1c1c),
      surfaceContainer: Color(0xff1f2020),
      surfaceContainerHigh: Color(0xff292a2a),
      surfaceContainerHighest: Color(0xff343535),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffecfeff),
      surfaceTint: Color(0xff53d9e0),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff59dde4),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9f8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffbba4),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9f9),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffb7c7),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9fa),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffb3eb),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121413),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff0fdfe),
      outline: Color(0xffc0cdce),
      outlineVariant: Color(0xffc0cdce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e1),
      inversePrimary: Color(0xff003032),
      primaryFixed: Color(0xff85f9ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff59dde4),
      onPrimaryFixedVariant: Color(0xff001a1b),
      secondaryFixed: Color(0xffffe0d7),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffbba4),
      onSecondaryFixedVariant: Color(0xff2f0900),
      tertiaryFixed: Color(0xffffdfe4),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb7c7),
      onTertiaryFixedVariant: Color(0xff350014),
      surfaceDim: Color(0xff121413),
      surfaceBright: Color(0xff383939),
      surfaceContainerLowest: Color(0xff0d0e0e),
      surfaceContainerLow: Color(0xff1b1c1c),
      surfaceContainer: Color(0xff1f2020),
      surfaceContainerHigh: Color(0xff292a2a),
      surfaceContainerHighest: Color(0xff343535),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );

  /// Custom Color 1
  static const customColor1 = ExtendedColor(
    seed: Color(0xff261447),
    value: Color(0xff1a184b),
    light: ColorFamily(
      color: Color(0xff060239),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff282659),
      onColorContainer: Color(0xffb6b4f0),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff060239),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff282659),
      onColorContainer: Color(0xffb6b4f0),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff060239),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff282659),
      onColorContainer: Color(0xffb6b4f0),
    ),
    dark: ColorFamily(
      color: Color(0xffc3c1fe),
      onColor: Color(0xff2c2a5d),
      colorContainer: Color(0xff121044),
      onColorContainer: Color(0xffa09ed9),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffc3c1fe),
      onColor: Color(0xff2c2a5d),
      colorContainer: Color(0xff121044),
      onColorContainer: Color(0xffa09ed9),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffc3c1fe),
      onColor: Color(0xff2c2a5d),
      colorContainer: Color(0xff121044),
      onColorContainer: Color(0xffa09ed9),
    ),
  );

  /// Custom Color 2
  static const customColor2 = ExtendedColor(
    seed: Color(0xffee6055),
    value: Color(0xffee6055),
    light: ColorFamily(
      color: Color(0xff99221e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffcb473e),
      onColorContainer: Color(0xffffffff),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff99221e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffcb473e),
      onColorContainer: Color(0xffffffff),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff99221e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffcb473e),
      onColorContainer: Color(0xffffffff),
    ),
    dark: ColorFamily(
      color: Color(0xffffb4ab),
      onColor: Color(0xff690006),
      colorContainer: Color(0xffcb473e),
      onColorContainer: Color(0xffffffff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb4ab),
      onColor: Color(0xff690006),
      colorContainer: Color(0xffcb473e),
      onColorContainer: Color(0xffffffff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb4ab),
      onColor: Color(0xff690006),
      colorContainer: Color(0xffcb473e),
      onColorContainer: Color(0xffffffff),
    ),
  );

  /// Custom Color 3
  static const customColor3 = ExtendedColor(
    seed: Color(0xffeeaa66),
    value: Color(0xffeeaa66),
    light: ColorFamily(
      color: Color(0xff875216),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff7b26d),
      onColorContainer: Color(0xff4c2a00),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff875216),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff7b26d),
      onColorContainer: Color(0xff4c2a00),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff875216),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff7b26d),
      onColorContainer: Color(0xff4c2a00),
    ),
    dark: ColorFamily(
      color: Color(0xffffd4ad),
      onColor: Color(0xff4a2800),
      colorContainer: Color(0xffe8a461),
      onColorContainer: Color(0xff3d2000),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffd4ad),
      onColor: Color(0xff4a2800),
      colorContainer: Color(0xffe8a461),
      onColorContainer: Color(0xff3d2000),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffd4ad),
      onColor: Color(0xff4a2800),
      colorContainer: Color(0xffe8a461),
      onColorContainer: Color(0xff3d2000),
    ),
  );

  /// Custom Color 4
  static const customColor4 = ExtendedColor(
    seed: Color(0xff89023e),
    value: Color(0xff89023e),
    light: ColorFamily(
      color: Color(0xff65002c),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff9d1a4c),
      onColorContainer: Color(0xfffff0f1),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff65002c),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff9d1a4c),
      onColorContainer: Color(0xfffff0f1),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff65002c),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff9d1a4c),
      onColorContainer: Color(0xfffff0f1),
    ),
    dark: ColorFamily(
      color: Color(0xffffb1c3),
      onColor: Color(0xff66002c),
      colorContainer: Color(0xff7a0036),
      onColorContainer: Color(0xffffbcca),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb1c3),
      onColor: Color(0xff66002c),
      colorContainer: Color(0xff7a0036),
      onColorContainer: Color(0xffffbcca),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb1c3),
      onColor: Color(0xff66002c),
      colorContainer: Color(0xff7a0036),
      onColorContainer: Color(0xffffbcca),
    ),
  );

  /// Custom Color 5
  static const customColor5 = ExtendedColor(
    seed: Color(0xff571f4e),
    value: Color(0xff571f4e),
    light: ColorFamily(
      color: Color(0xff410a3b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff682e5e),
      onColorContainer: Color(0xffffccef),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff410a3b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff682e5e),
      onColorContainer: Color(0xffffccef),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff410a3b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff682e5e),
      onColorContainer: Color(0xffffccef),
    ),
    dark: ColorFamily(
      color: Color(0xfffaafe7),
      onColor: Color(0xff511a49),
      colorContainer: Color(0xff4d1645),
      onColorContainer: Color(0xffeca1d9),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xfffaafe7),
      onColor: Color(0xff511a49),
      colorContainer: Color(0xff4d1645),
      onColorContainer: Color(0xffeca1d9),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xfffaafe7),
      onColor: Color(0xff511a49),
      colorContainer: Color(0xff4d1645),
      onColorContainer: Color(0xffeca1d9),
    ),
  );

  /// Custom Color 6
  static const customColor6 = ExtendedColor(
    seed: Color(0xffff3864),
    value: Color(0xffff3864),
    light: ColorFamily(
      color: Color(0xffa30034),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe21d51),
      onColorContainer: Color(0xffffffff),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xffa30034),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe21d51),
      onColorContainer: Color(0xffffffff),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xffa30034),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe21d51),
      onColorContainer: Color(0xffffffff),
    ),
    dark: ColorFamily(
      color: Color(0xffffb2b9),
      onColor: Color(0xff67001e),
      colorContainer: Color(0xffe21d51),
      onColorContainer: Color(0xffffffff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb2b9),
      onColor: Color(0xff67001e),
      colorContainer: Color(0xffe21d51),
      onColorContainer: Color(0xffffffff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb2b9),
      onColor: Color(0xff67001e),
      colorContainer: Color(0xffe21d51),
      onColorContainer: Color(0xffffffff),
    ),
  );

  /// Custom Color 7
  static const customColor7 = ExtendedColor(
    seed: Color(0xffbf4342),
    value: Color(0xffbf4342),
    light: ColorFamily(
      color: Color(0xff8e1e22),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffbf4342),
      onColorContainer: Color(0xffffffff),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff8e1e22),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffbf4342),
      onColorContainer: Color(0xffffffff),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff8e1e22),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffbf4342),
      onColorContainer: Color(0xffffffff),
    ),
    dark: ColorFamily(
      color: Color(0xffffb3ae),
      onColor: Color(0xff68000c),
      colorContainer: Color(0xffb33b3a),
      onColorContainer: Color(0xffffffff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb3ae),
      onColor: Color(0xff68000c),
      colorContainer: Color(0xffb33b3a),
      onColorContainer: Color(0xffffffff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb3ae),
      onColor: Color(0xff68000c),
      colorContainer: Color(0xffb33b3a),
      onColorContainer: Color(0xffffffff),
    ),
  );

  /// Custom Color 8
  static const customColor8 = ExtendedColor(
    seed: Color(0xff2f3e46),
    value: Color(0xff2f3e46),
    light: ColorFamily(
      color: Color(0xff1d2c34),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff3e4e56),
      onColorContainer: Color(0xffdaeaf5),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff1d2c34),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff3e4e56),
      onColorContainer: Color(0xffdaeaf5),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff1d2c34),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff3e4e56),
      onColorContainer: Color(0xffdaeaf5),
    ),
    dark: ColorFamily(
      color: Color(0xffb9c9d3),
      onColor: Color(0xff23323a),
      colorContainer: Color(0xff25343c),
      onColorContainer: Color(0xffb3c3cd),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffb9c9d3),
      onColor: Color(0xff23323a),
      colorContainer: Color(0xff25343c),
      onColorContainer: Color(0xffb3c3cd),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffb9c9d3),
      onColor: Color(0xff23323a),
      colorContainer: Color(0xff25343c),
      onColorContainer: Color(0xffb3c3cd),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    customColor1,
    customColor2,
    customColor3,
    customColor4,
    customColor5,
    customColor6,
    customColor7,
    customColor8,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData get light {
    return FlexThemeData.light(
      scheme: FlexScheme.materialBaseline,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      appBarStyle: FlexAppBarStyle.scaffoldBackground,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useM2StyleDividerInM3: true,
        fabUseShape: true,
        fabAlwaysCircular: true,
        fabSchemeColor: SchemeColor.onPrimaryContainer,
        appBarScrolledUnderElevation: 1,
        bottomSheetRadius: 10.0,
        inputDecoratorIsFilled: false,
        inputDecoratorFocusedHasBorder: false,
        inputDecoratorUnfocusedHasBorder: false,
        inputDecoratorRadius: 17,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: 'Nunito',
      extensions: [CardColors.light()],
    );
  }

  static ThemeData get dark {
    return FlexThemeData.dark(
      scheme: FlexScheme.materialBaseline,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 40,
      appBarStyle: FlexAppBarStyle.scaffoldBackground,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 15,
        useM2StyleDividerInM3: true,
        fabUseShape: true,
        fabAlwaysCircular: true,
        fabSchemeColor: SchemeColor.onPrimary,
        appBarScrolledUnderElevation: 1,
        bottomSheetRadius: 10.0,
        inputDecoratorIsFilled: false,
        inputDecoratorFocusedHasBorder: false,
        inputDecoratorUnfocusedHasBorder: false,
        inputDecoratorRadius: 17,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: 'Nunito',
      extensions: [CardColors.dark()],
    );
  }
}

class CardColors extends ThemeExtension<CardColors> {
  final Color lightPink;
  final Color lightOrange;
  final Color lightGreen;
  final Color lightYellow;
  final Color lightTurquoise;
  final Color lightPurple;

  const CardColors.raw({
    required this.lightPink,
    required this.lightOrange,
    required this.lightGreen,
    required this.lightYellow,
    required this.lightTurquoise,
    required this.lightPurple,
  });

  factory CardColors.light() {
    return const CardColors.raw(
      lightPink: Color(0XFFFD99FF),
      lightOrange: Color(0XFFFF9E9E),
      lightGreen: Color(0XFF91F48F),
      lightYellow: Color(0XFFFFF599),
      lightTurquoise: Color(0XFF9EFFFF),
      lightPurple: Color(0XFFB69CFF),
    );
  }

  factory CardColors.dark() {
    return CardColors.raw(
      lightPink: const Color(0XFFFD99FF).darken(50),
      lightOrange: const Color(0XFFFF9E9E).darken(50),
      lightGreen: const Color(0XFF91F48F).darken(50),
      lightYellow: const Color(0XFFFFF599).darken(50),
      lightTurquoise: const Color(0XFF9EFFFF).darken(50),
      lightPurple: const Color(0XFFB69CFF).darken(50),
    );
  }

  List<Color> get colors {
    return [
      lightPink,
      lightOrange,
      lightGreen,
      lightYellow,
      lightTurquoise,
      lightPurple,
    ];
  }

  @override
  ThemeExtension<CardColors> copyWith({
    Color? lightPink,
    Color? lightOrange,
    Color? lightGreen,
    Color? lightYellow,
    Color? lightTurquoise,
    Color? lightPurple,
  }) {
    return CardColors.raw(
      lightPink: lightPink ?? this.lightPink,
      lightOrange: lightOrange ?? this.lightOrange,
      lightGreen: lightGreen ?? this.lightGreen,
      lightYellow: lightYellow ?? this.lightYellow,
      lightTurquoise: lightTurquoise ?? this.lightTurquoise,
      lightPurple: lightPurple ?? this.lightPurple,
    );
  }

  @override
  ThemeExtension<CardColors> lerp(covariant CardColors? other, double t) {
    if (other is! CardColors) return this;
    return CardColors.raw(
      lightPink: Color.lerp(lightPink, other.lightPink, t)!,
      lightOrange: Color.lerp(lightOrange, other.lightOrange, t)!,
      lightGreen: Color.lerp(lightGreen, other.lightGreen, t)!,
      lightYellow: Color.lerp(lightYellow, other.lightYellow, t)!,
      lightTurquoise: Color.lerp(lightTurquoise, other.lightTurquoise, t)!,
      lightPurple: Color.lerp(lightPurple, other.lightPurple, t)!,
    );
  }
}

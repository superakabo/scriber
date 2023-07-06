import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData get light {
    return FlexThemeData.light(
      scheme: FlexScheme.materialBaseline,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      appBarElevation: 0,
      appBarStyle: FlexAppBarStyle.scaffoldBackground,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useM2StyleDividerInM3: true,
        fabUseShape: true,
        fabAlwaysCircular: true,
        fabSchemeColor: SchemeColor.onPrimaryContainer,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: 'Nunito',
    );
  }

  static ThemeData get dark {
    return FlexThemeData.dark(
      scheme: FlexScheme.materialBaseline,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 40,
      appBarElevation: 0,
      appBarStyle: FlexAppBarStyle.scaffoldBackground,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 15,
        useM2StyleDividerInM3: true,
        fabUseShape: true,
        fabAlwaysCircular: true,
        fabSchemeColor: SchemeColor.onPrimary,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: 'Nunito',
    );
  }
}

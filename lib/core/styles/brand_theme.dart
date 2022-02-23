import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/index.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: BrandColors.colorBackground,
    colorScheme: const ColorScheme.light().copyWith(
      primary: BrandColors.kPrimaryColor,
      secondary: BrandColors.colorBlue,
      error: BrandColors.kErrorColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    textTheme: GoogleFonts.interTextTheme(
      Theme.of(context).textTheme.apply(
            bodyColor: BrandColors.kDarkGray,
          ),
    ),
    hintColor: BrandColors.kLightGray,
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: BrandColors.colorBackground,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: BrandColors.kPrimaryColor,
      error: BrandColors.kErrorColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    textTheme: GoogleFonts.interTextTheme(
      Theme.of(context).textTheme.apply(
            bodyColor: BrandColors.kDarkGray,
          ),
    ),
    hintColor: BrandColors.kLightGray,
  );
}

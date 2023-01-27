import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaTheme {
  /// Initialize the theme by setting the system navigation and system colours.
  void initialize() {
    //Set system UI overlay style (navbar, statusbar)
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  }

  /// Returns the active [ThemeData] by checking the theme database value.
  ThemeData activeTheme() {
    return isAMOLEDTheme ? _pureBlackTheme() : _midnightTheme();
  }

  static bool get isAMOLEDTheme => LunaSeaDatabase.THEME_AMOLED.read();
  static bool get useBorders => LunaSeaDatabase.THEME_AMOLED_BORDER.read();

  /// Midnight theme (Default)
  ThemeData _midnightTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      canvasColor: LunaColours.primary,
      primaryColor: LunaColours.secondary,
      highlightColor: LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH / 2),
      cardColor: LunaColours.secondary,
      hoverColor: LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH / 2),
      splashColor: LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH),
      dialogBackgroundColor: LunaColours.secondary,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      tooltipTheme: const TooltipThemeData(
        decoration: BoxDecoration(
          color: LunaColours.secondary,
          borderRadius: BorderRadius.all(Radius.circular(LunaUI.BORDER_RADIUS)),
        ),
        textStyle: TextStyle(
          color: LunaColours.grey,
          fontSize: LunaUI.FONT_SIZE_SUBHEADER,
        ),
        preferBelow: true,
      ),
      unselectedWidgetColor: Colors.white,
      textTheme: _sharedTextTheme,
      textButtonTheme: _sharedTextButtonThemeData,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  /// AMOLED/Pure black theme
  ThemeData _pureBlackTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      canvasColor: Colors.black,
      primaryColor: Colors.black,
      highlightColor: LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH / 2),
      cardColor: Colors.black,
      hoverColor: LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH / 2),
      splashColor: LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH),
      dialogBackgroundColor: Colors.black,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.all(
            Radius.circular(LunaUI.BORDER_RADIUS),
          ),
          border: useBorders ? Border.all(color: LunaColours.white10) : null,
        ),
        textStyle: const TextStyle(
          color: LunaColours.grey,
          fontSize: LunaUI.FONT_SIZE_SUBHEADER,
        ),
        preferBelow: true,
      ),
      unselectedWidgetColor: Colors.white,
      textTheme: _sharedTextTheme,
      textButtonTheme: _sharedTextButtonThemeData,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  SystemUiOverlayStyle get overlayStyle {
    return SystemUiOverlayStyle(
      systemNavigationBarColor: LunaSeaDatabase.THEME_AMOLED.read()
          ? Colors.black
          : LunaColours.secondary,
      systemNavigationBarDividerColor: LunaSeaDatabase.THEME_AMOLED.read()
          ? Colors.black
          : LunaColours.secondary,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    );
  }

  TextTheme get _sharedTextTheme {
    const textStyle = TextStyle(color: Colors.white);
    return const TextTheme(
      displaySmall: textStyle,
      displayMedium: textStyle,
      displayLarge: textStyle,
      headlineSmall: textStyle,
      headlineMedium: textStyle,
      headlineLarge: textStyle,
      bodySmall: textStyle,
      bodyMedium: textStyle,
      bodyLarge: textStyle,
      titleSmall: textStyle,
      titleMedium: textStyle,
      titleLarge: textStyle,
      labelSmall: textStyle,
      labelMedium: textStyle,
      labelLarge: textStyle,
    );
  }

  TextButtonThemeData get _sharedTextButtonThemeData {
    return TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(
          LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH),
        ),
      ),
    );
  }
}

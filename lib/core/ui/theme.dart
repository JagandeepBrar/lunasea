import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaTheme {
  /// Initialize the theme by setting the system navigation and system colours.
  void initialize() {
    //Set system UI overlay style (navbar, statusbar)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: LunaDatabaseValue.THEME_AMOLED.data
          ? Colors.black
          : LunaColours.secondary,
      systemNavigationBarDividerColor: LunaDatabaseValue.THEME_AMOLED.data
          ? Colors.black
          : LunaColours.secondary,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
  }

  /// Returns the active [ThemeData] by checking the theme database value.
  ThemeData activeTheme() {
    return isAMOLEDTheme ? _pureBlackTheme() : _midnightTheme();
  }

  static bool get isAMOLEDTheme => LunaDatabaseValue.THEME_AMOLED.data;
  static bool get useAMOLEDBorders =>
      LunaDatabaseValue.THEME_AMOLED_BORDER.data;

  /// Midnight theme (Default)
  ThemeData _midnightTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      canvasColor: LunaColours.primary,
      primaryColor: LunaColours.secondary,
      highlightColor: LunaColours.splash.withOpacity(LunaUI.OPACITY_SPLASH / 2),
      cardColor: LunaColours.secondary,
      hoverColor: LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH / 2),
      splashColor: LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH),
      dialogBackgroundColor: LunaColours.secondary,
      toggleableActiveColor: LunaColours.accent,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      tooltipTheme: const TooltipThemeData(
        decoration: BoxDecoration(
          color: LunaColours.secondary,
          borderRadius: BorderRadius.all(Radius.circular(LunaUI.BORDER_RADIUS)),
        ),
        textStyle: TextStyle(
          color: Colors.white70,
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
      highlightColor: LunaColours.splash.withOpacity(LunaUI.OPACITY_SPLASH / 2),
      cardColor: Colors.black,
      hoverColor: LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH / 2),
      splashColor: LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH),
      dialogBackgroundColor: Colors.black,
      toggleableActiveColor: LunaColours.accent,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.all(
            Radius.circular(LunaUI.BORDER_RADIUS),
          ),
          border: useAMOLEDBorders ? Border.all(color: Colors.white12) : null,
        ),
        textStyle: const TextStyle(
          color: Colors.white70,
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

  TextTheme get _sharedTextTheme {
    const textStyle = TextStyle(color: Colors.white);
    return const TextTheme(
      bodyText1: textStyle,
      bodyText2: textStyle,
      headline1: textStyle,
      headline2: textStyle,
      headline3: textStyle,
      headline4: textStyle,
      headline5: textStyle,
      headline6: textStyle,
      button: textStyle,
      caption: textStyle,
      subtitle1: textStyle,
      subtitle2: textStyle,
      overline: textStyle,
    );
  }

  TextButtonThemeData get _sharedTextButtonThemeData {
    return TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(
          LunaColours.splash.withOpacity(LunaUI.OPACITY_SPLASH),
        ),
      ),
    );
  }
}

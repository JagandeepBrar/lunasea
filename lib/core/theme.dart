import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaTheme {
    /// Returns the active [ThemeData] by checking the theme database value.
    ThemeData activeTheme() {
        return LunaDatabaseValue.THEME_AMOLED.data ? _pureBlackTheme() : _midnightTheme();
    }

    /// Midnight theme (Default)
    ThemeData _midnightTheme() {
        const _textStyle = TextStyle(color: Colors.white);
        return ThemeData(
            brightness: Brightness.dark,
            canvasColor: LunaColours.primary,
            primaryColor: LunaColours.secondary,
            accentColor: LunaColours.accent,
            highlightColor: LunaColours.secondary,
            cardColor: LunaColours.secondary,
            splashColor: LunaColours.splash,
            dialogBackgroundColor: LunaColours.secondary,
            toggleableActiveColor: LunaColours.accent,
            iconTheme: IconThemeData(
                color: Colors.white,
            ),
            unselectedWidgetColor: Colors.white,
            textTheme: TextTheme(
                bodyText1: _textStyle,
                bodyText2: _textStyle,
                headline1: _textStyle,
                headline2: _textStyle,
                headline3: _textStyle,
                headline4: _textStyle,
                headline5: _textStyle,
                headline6: _textStyle,
                button: _textStyle,
                caption: _textStyle,
                subtitle1: _textStyle,
                subtitle2: _textStyle,
                overline: _textStyle,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
        );
    }

    /// AMOLED/Pure black theme
    ThemeData _pureBlackTheme() {
        const _textStyle = TextStyle(color: Colors.white);
        return ThemeData(
            brightness: Brightness.dark,
            canvasColor: Colors.black,
            primaryColor: Colors.black,
            accentColor: LunaColours.accent,
            highlightColor: LunaColours.secondary,
            cardColor: Colors.black,
            splashColor: LunaColours.splash,
            dialogBackgroundColor: Colors.black,
            toggleableActiveColor: LunaColours.accent,
            iconTheme: IconThemeData(
                color: Colors.white,
            ),
            unselectedWidgetColor: Colors.white,
            textTheme: TextTheme(
                bodyText1: _textStyle,
                bodyText2: _textStyle,
                headline1: _textStyle,
                headline2: _textStyle,
                headline3: _textStyle,
                headline4: _textStyle,
                headline5: _textStyle,
                headline6: _textStyle,
                button: _textStyle,
                caption: _textStyle,
                subtitle1: _textStyle,
                subtitle2: _textStyle,
                overline: _textStyle,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
        );
    }
}
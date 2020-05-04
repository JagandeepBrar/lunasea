import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class Themes {
    Themes._();

    static ThemeData getDarkTheme() => LunaSeaDatabaseValue.THEME_AMOLED.data
        ? _pureBlackTheme()
        : _midnightTheme();

    static ThemeData _midnightTheme() {
        const _textStyle = TextStyle(
            color: Colors.white,
        );
        return ThemeData(
            brightness: Brightness.dark,
            canvasColor: LSColors.primary,
            primaryColor: LSColors.secondary,
            accentColor: LSColors.accent,
            highlightColor: LSColors.secondary,
            cardColor: LSColors.secondary,
            splashColor: LSColors.splash,
            dialogBackgroundColor: LSColors.secondary,
            dividerColor: LSColors.accent.withAlpha(0),
            dividerTheme: DividerThemeData(
                color: LSColors.accent,
                indent: 100.0,
                endIndent: 100.0,
            ),
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

    static ThemeData _pureBlackTheme() {
        const _textStyle = TextStyle(
            color: Colors.white,
        );
        return ThemeData(
            brightness: Brightness.dark,
            canvasColor: Colors.black,
            primaryColor: Colors.black,
            accentColor: LSColors.accent,
            highlightColor: LSColors.secondary,
            cardColor: Colors.black,
            splashColor: LSColors.splash,
            dialogBackgroundColor: Colors.black,
            dividerColor: LSColors.accent.withAlpha(0),
            dividerTheme: DividerThemeData(
                color: LSColors.accent,
                indent: 72.0,
                endIndent: 72.0,
            ),
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
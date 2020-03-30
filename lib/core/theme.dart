import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class Themes {
    Themes._();

    static ThemeData getDefaultTheme() {
        const _textStyle = TextStyle(
            color: Colors.white,
            letterSpacing: Constants.UI_LETTER_SPACING,
        );

        return ThemeData(
            canvasColor: LSColors.primary,
            primaryColor: LSColors.secondary,
            accentColor: LSColors.accent,
            highlightColor: LSColors.secondary,
            cardColor: LSColors.secondary,
            splashColor: LSColors.splash,
            dialogBackgroundColor: LSColors.secondary,
            dividerColor: LSColors.accent.withAlpha(0),
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
        );
    }
}
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
                body1: _textStyle,
                body2: _textStyle,
                display1: _textStyle,
                display2: _textStyle,
                display3: _textStyle,
                display4: _textStyle,
                headline: _textStyle,
                button: _textStyle,
                caption: _textStyle,
                title: _textStyle,
                subtitle: _textStyle,
                subhead: _textStyle,
                overline: _textStyle,
            ),
        );
    }
}
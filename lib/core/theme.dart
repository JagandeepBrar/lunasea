import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';

class Themes {
    Themes._();

    static ThemeData getDefaultTheme() {
        const _textStyle = TextStyle(
            color: Colors.white,
            letterSpacing: Constants.UI_LETTER_SPACING,
        );

        return ThemeData(
            canvasColor: Color(Constants.PRIMARY_COLOR),
            primaryColor: Color(Constants.SECONDARY_COLOR),
            accentColor: Color(Constants.ACCENT_COLOR),
            highlightColor: Color(Constants.SECONDARY_COLOR),
            cardColor: Color(Constants.SECONDARY_COLOR),
            splashColor: Color(Constants.SPLASH_COLOR),
            dialogBackgroundColor: Color(Constants.SECONDARY_COLOR),
            dividerColor: Color(Constants.ACCENT_COLOR).withAlpha(0),
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
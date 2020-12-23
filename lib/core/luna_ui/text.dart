import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaText extends Text {
    /// Create a new [Text] widget.
    LunaText({
        @required String text,
        Key key,
        int maxLines,
        TextOverflow overflow,
        bool softWrap,
        TextStyle style,
        TextAlign textAlign,
    }) : super(
        text,
        key: key,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        style: style,
        textAlign: textAlign,
    );

    /// Create a [Text] widget with the styling pre-assigned to be a LunaSea title.
    factory LunaText.title({
        @required String text,
        Key key,
        int maxLines = 1,
        bool softWrap = false,
        TextAlign textAlign = TextAlign.start,
        Color color = Colors.white,
        bool darken = false,
    }) => LunaText(
        text: text,
        key: key,
        maxLines: maxLines,
        overflow: TextOverflow.fade,
        softWrap: softWrap,
        textAlign: textAlign,
        style: TextStyle(
            color: darken ? color.withOpacity(0.3) : color,
            fontWeight: FontWeight.bold,
            fontSize: Constants.UI_FONT_SIZE_TITLE,
        ),
    );
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaText extends Text {
  /// Create a new [Text] widget.
  const LunaText({
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
          maxLines: maxLines == 0 ? null : maxLines,
          overflow: overflow,
          softWrap: softWrap,
          style: style,
          textAlign: textAlign,
        );

  /// Create a [LunaText] widget with the styling pre-assigned to be a LunaSea title.
  factory LunaText.title({
    Key key,
    @required String text,
    int maxLines = 1,
    bool softWrap = false,
    TextAlign textAlign = TextAlign.start,
    Color color = Colors.white,
    bool darken = false,
  }) =>
      LunaText(
        text: text,
        key: key,
        maxLines: maxLines,
        overflow: TextOverflow.fade,
        softWrap: softWrap,
        textAlign: textAlign,
        style: TextStyle(
          color: darken ? color.withOpacity(0.30) : color,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          fontSize: LunaUI.FONT_SIZE_H2,
        ),
      );

  /// Create a [LunaText] widget with the styling pre-assigned to be a LunaSea subtitle.
  factory LunaText.subtitle({
    Key key,
    @required String text,
    int maxLines = 1,
    bool softWrap = false,
    TextAlign textAlign = TextAlign.start,
    Color color = Colors.white70,
    bool darken = false,
    FontStyle fontStyle = FontStyle.normal,
  }) =>
      LunaText(
        key: key,
        text: text,
        softWrap: softWrap,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: TextOverflow.fade,
        style: TextStyle(
          color: darken ? color.withOpacity(0.30) : color,
          fontSize: LunaUI.FONT_SIZE_H3,
          fontStyle: fontStyle,
        ),
      );
}

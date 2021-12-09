import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaListTile extends Card {
  static const _baseHeight = 25.0;
  static const _perLineHeight = 22.0;
  static final double itemExtent = _baseHeight + LunaUI.MARGIN_CARD.vertical;

  static double itemHeightExtended(int subtitleLines) {
    if (subtitleLines == 0) return _baseHeight;
    return _baseHeight + (subtitleLines * _perLineHeight);
  }

  static double itemExtentExtended(int subtitleLines) {
    return itemHeightExtended(subtitleLines) + LunaUI.MARGIN_CARD.vertical;
  }

  LunaListTile({
    Key key,
    @required BuildContext context,
    @required Widget title,
    Widget subtitle,
    Widget trailing,
    Widget leading,
    Color color,
    Decoration decoration,
    Function onTap,
    Function onLongPress,
    bool contentPadding = false,
    double height,
    EdgeInsets margin = LunaUI.MARGIN_CARD,
  }) : super(
          key: key,
          child: Container(
            height: height ??
                (subtitle == null
                    ? itemHeightExtended(0)
                    : itemHeightExtended(1)),
            child: InkWell(
              mouseCursor: onTap != null || onLongPress != null
                  ? SystemMouseCursors.click
                  : null,
              child: Row(
                children: [
                  if (leading != null)
                    Padding(
                      padding:
                          EdgeInsets.only(left: LunaUI.MARGIN_CARD.left / 2),
                      child: SizedBox(
                        width: 48.0,
                        child: leading,
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          title,
                          if (subtitle != null) subtitle,
                        ],
                      ),
                      padding: EdgeInsets.only(
                        top: LunaUI.DEFAULT_MARGIN_SIZE,
                        bottom: LunaUI.DEFAULT_MARGIN_SIZE,
                        left: leading != null ? 0 : LunaUI.DEFAULT_MARGIN_SIZE,
                        right:
                            trailing != null ? 0 : LunaUI.DEFAULT_MARGIN_SIZE,
                      ),
                    ),
                  ),
                  if (trailing != null)
                    Padding(
                      padding:
                          EdgeInsets.only(right: LunaUI.MARGIN_CARD.right / 2),
                      child: SizedBox(
                        width: 48.0,
                        child: trailing,
                      ),
                    ),
                ],
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: onTap,
              onLongPress: onLongPress,
            ),
            decoration: decoration,
          ),
          margin: margin,
          elevation: LunaUI.ELEVATION,
          shape: LunaUI.shapeBorder,
          color: color ?? Theme.of(context).primaryColor,
        );
}

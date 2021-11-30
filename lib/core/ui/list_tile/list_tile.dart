import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaListTile extends Card {
  LunaListTile({
    Key key,
    EdgeInsets margin = LunaUI.MARGIN_CARD,
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
    EdgeInsets customContentPadding,
  }) : super(
          key: key,
          child: Container(
            child: InkWell(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: title,
                      subtitle: subtitle,
                      // trailing: trailing,
                      leading: leading,
                      mouseCursor: onTap != null || onLongPress != null
                          ? SystemMouseCursors.click
                          : null,
                      contentPadding: contentPadding
                          ? customContentPadding?.copyWith(
                                right: trailing != null ? 0 : null,
                              ) ??
                              LunaUI.MARGIN_CARD.copyWith(
                                right: trailing != null ? 0 : null,
                              )
                          : LunaUI.MARGIN_CARD.copyWith(
                              top: 0,
                              bottom: 0,
                              right: trailing != null ? 0 : null,
                            ),
                    ),
                  ),
                  if (trailing != null)
                    Padding(
                      padding: EdgeInsets.only(right: LunaUI.MARGIN_CARD.right),
                      child: SizedBox(
                        width: 48.0,
                        child: trailing,
                      ),
                    ),
                ],
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              mouseCursor: SystemMouseCursors.click,
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

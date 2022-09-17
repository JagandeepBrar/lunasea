import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

@Deprecated("Use LunaBlock instead")
class LunaListTile extends Card {
  LunaListTile({
    Key? key,
    required BuildContext context,
    required Widget title,
    required double height,
    Widget? subtitle,
    Widget? trailing,
    Widget? leading,
    Color? color,
    Decoration? decoration,
    Function? onTap,
    Function? onLongPress,
    bool drawBorder = true,
    EdgeInsets margin = LunaUI.MARGIN_H_DEFAULT_V_HALF,
  }) : super(
          key: key,
          child: Container(
            height: height,
            child: InkWell(
              child: Row(
                children: [
                  if (leading != null)
                    SizedBox(
                      width: LunaUI.DEFAULT_MARGIN_SIZE * 4 +
                          LunaUI.DEFAULT_MARGIN_SIZE / 2,
                      child: leading,
                    ),
                  Expanded(
                    child: Padding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: title,
                            height: LunaBlock.TITLE_HEIGHT,
                          ),
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
                      padding: const EdgeInsets.only(
                        right: LunaUI.DEFAULT_MARGIN_SIZE / 2,
                      ),
                      child: SizedBox(
                        width: LunaUI.DEFAULT_MARGIN_SIZE * 4,
                        child: trailing,
                      ),
                    ),
                ],
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: onTap as void Function()?,
              onLongPress: onLongPress as void Function()?,
              mouseCursor: MouseCursor.defer,
            ),
            decoration: decoration,
          ),
          margin: margin,
          elevation: LunaUI.ELEVATION,
          shape: drawBorder ? LunaUI.shapeBorder : LunaShapeBorder(),
          color: color ?? Theme.of(context).primaryColor,
        );
}

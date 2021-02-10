import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaListTile extends Card {
    LunaListTile({
        Key key,
        @required BuildContext context,
        EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
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
                child: ListTile(
                    title: title,
                    subtitle: subtitle,
                    trailing: trailing,
                    leading: leading,
                    contentPadding: contentPadding
                        ? customContentPadding != null
                            ? customContentPadding
                            : EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0)
                        : null,
                ),
                borderRadius: BorderRadius.circular(LunaUI().borderRadius),
                onTap: onTap,
                onLongPress: onLongPress,
            ),
            decoration: decoration,
        ),
        margin: margin,
        elevation: LunaUI().elevation,
        shape: LunaUI().shapeBorder(),
        color: color ?? Theme.of(context).primaryColor,
    );
}
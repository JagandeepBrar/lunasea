import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaCard extends Card {
    LunaCard({
        Key key,
        @required BuildContext context,
        @required Widget child,
        EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        Color color,
        Decoration decoration,
    }) : super(
        key: key,
        child: Container(child: child, decoration: decoration),
        margin: margin,
        color: color == null ? Theme.of(context).primaryColor : color,
        shape: LunaUI().shapeBorder(),
    ) {
        assert(context != null);
        assert(child != null);
    }
}

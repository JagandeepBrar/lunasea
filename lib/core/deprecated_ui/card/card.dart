import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSCard extends StatelessWidget {
    final Widget child;
    final EdgeInsets margin;
    final bool reducedMargin;
    final Color color;
    final Decoration decoration;

    LSCard({
        @required this.child,
        this.margin = LunaUI.MARGIN_CARD,
        this.reducedMargin = false,
        this.color,
        this.decoration,
    });

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaDatabaseValue.THEME_AMOLED.key,
            LunaDatabaseValue.THEME_AMOLED_BORDER.key,
        ]),
        builder: (context, box, widget) => Card(
            child: Container(
                child: child,
                decoration: decoration,
            ),
            elevation: LunaUI.ELEVATION,
            margin: reducedMargin
                ? EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0)
                : margin,
            color: color == null
                ? Theme.of(context).primaryColor
                : color,
            shape: LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data
                ? LSRoundedShapeWithBorder()
                : LSRoundedShape(),
        ),
    );
}

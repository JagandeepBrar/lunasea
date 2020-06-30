import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSCard extends StatelessWidget {
    final Widget child;
    final EdgeInsets margin;
    final bool reducedMargin;
    final Color color;

    LSCard({
        @required this.child,
        this.margin = Constants.UI_CARD_MARGIN,
        this.reducedMargin = false,
        this.color,
    });

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaSeaDatabaseValue.THEME_AMOLED.key,
            LunaSeaDatabaseValue.THEME_AMOLED_BORDER.key,
        ]),
        builder: (context, box, widget) => Card(
            child: child,
            elevation: Constants.UI_ELEVATION,
            margin: reducedMargin
                ? EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0)
                : margin,
            color: color == null
                ? Theme.of(context).primaryColor
                : color,
            shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                ? LSRoundedShapeWithBorder()
                : LSRoundedShape(),
        ),
    );
}

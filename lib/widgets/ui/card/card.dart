import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';

class LSCard extends StatelessWidget {
    final Widget child;
    final EdgeInsets margin;

    LSCard({
        @required this.child,
        this.margin = Constants.UI_CARD_MARGIN,
    });

    @override
    Widget build(BuildContext context) => Card(
        child: child,
        elevation: Constants.UI_ELEVATION,
        margin: margin,
    );
}

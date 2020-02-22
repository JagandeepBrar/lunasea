import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';

class LSCard extends StatelessWidget {
    final Widget child;

    LSCard({
        @required this.child,
    });

    @override
    Widget build(BuildContext context) {
        return Card(
            child: child,
            elevation: Constants.UI_ELEVATION,
            margin: Constants.UI_CARD_MARGIN,
        );
    }
}

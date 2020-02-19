import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';

class LSCard extends StatelessWidget {
    final Widget title;
    final Widget subtitle;
    final Widget trailing;
    final Widget leading;
    final Function onTap;
    final Function onLongPress;

    LSCard({
        @required this.title,
        @required this.subtitle,
        this.trailing,
        this.leading,
        this.onTap,
        this.onLongPress,
    });

    @override
    Widget build(BuildContext context) {
        return Card(
            child: ListTile(
                title: title,
                subtitle: subtitle,
                trailing: trailing,
                leading: leading,
                onTap: onTap,
                onLongPress: onLongPress,
            ),
            margin: Constants.UI_CARD_MARGIN,
            elevation: Constants.UI_ELEVATION,
        );
    }
}
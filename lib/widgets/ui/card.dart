import 'package:flutter/material.dart';

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
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            elevation: 4.0,
        );
    }
}
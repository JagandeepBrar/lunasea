import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';

class LSCardTile extends StatelessWidget {
    final Widget title;
    final Widget subtitle;
    final Widget trailing;
    final Widget leading;
    final Function onTap;
    final Function onLongPress;
    final bool padContent;
    final bool reducedMargin;
    final EdgeInsets customPadding;
    final Decoration decoration;

    LSCardTile({
        @required this.title,
        this.subtitle,
        this.trailing,
        this.leading,
        this.onTap,
        this.onLongPress,
        this.padContent = false,
        this.decoration,
        this.reducedMargin = false,
        this.customPadding,
    });

    @override
    Widget build(BuildContext context) => Card(
        child: Container(
            child: ListTile(
                title: title,
                subtitle: subtitle,
                trailing: trailing,
                leading: leading,
                onTap: onTap,
                onLongPress: onLongPress,
                contentPadding: customPadding == null
                    ? padContent
                        ? EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0)
                        : null
                    : customPadding,
            ),
            decoration: decoration,
        ),
        margin: reducedMargin
            ? EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0)
            : Constants.UI_CARD_MARGIN,
        elevation: Constants.UI_ELEVATION,
    );
}

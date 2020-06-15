import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSCardStickyHeader extends StatelessWidget {
    final String text;
    final Function onTap;
    final Function onLongPress;

    LSCardStickyHeader({
        Key key,
        @required this.text,
        this.onTap,
        this.onLongPress,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => Card(
        child: InkWell(
            child: ListTile(
                title: Text(
                    text,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.UI_FONT_SIZE_BUTTON,
                    ),
                ),
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: onTap,
            onLongPress: onLongPress,
        ),
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        shape: LSRoundedShape(),
    );
}

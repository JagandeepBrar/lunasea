import 'package:flutter/material.dart';

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
                    fontSize: 16.0,
                ),
            ),
            onTap: onTap,
            onLongPress: onLongPress,
        ),
        margin: EdgeInsets.symmetric(horizontal: 12.0),
    );
}

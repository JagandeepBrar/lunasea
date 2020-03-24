import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lunasea/core.dart';

class LSStickyHeader extends StatelessWidget {
    final String text;
    final List<Widget> children;
    final Function onTap;
    final Function onLongPress;

    LSStickyHeader({
        @required this.text,
        @required this.children,
        this.onTap,
        this.onLongPress,
    });

    @override
    Widget build(BuildContext context) => SliverStickyHeader(
        header: Card(
            child: ListTile(
                title: Text(
                    text,
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
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            elevation: Constants.UI_ELEVATION,
        ),
        sliver: SliverPadding(
            sliver: SliverList(
                delegate: (SliverChildListDelegate(children)),
            ),
            padding: EdgeInsets.symmetric(vertical: 6.0),
        ),
    );
}
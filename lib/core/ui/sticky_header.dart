import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class LSStickyHeader extends StatelessWidget {
    final List<Widget> children;
    final Widget header;

    LSStickyHeader({
        @required this.header,
        @required this.children,
    });

    @override
    Widget build(BuildContext context) => SliverStickyHeader(
        header: header,
        sliver: SliverPadding(
            sliver: SliverList(
                delegate: (SliverChildListDelegate(children)),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
    );
}

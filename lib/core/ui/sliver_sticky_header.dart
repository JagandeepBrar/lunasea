import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class LunaSliverStickyHeader extends SliverStickyHeader {
    LunaSliverStickyHeader({
        @required Widget header,
        @required List<Widget> children,
    }) : super(
        header: header,
        sliver: SliverPadding(
            sliver: SliverList(
                delegate: SliverChildListDelegate(children),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
    );
}

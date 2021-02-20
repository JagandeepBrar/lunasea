import 'package:flutter/material.dart';

class LunaListViewModal extends StatelessWidget {
    final List<Widget> children;

    LunaListViewModal({
        Key key,
        @required this.children,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scrollbar(
            child: ListView(
                children: children,
                padding: EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0+(MediaQuery.of(context).padding.bottom),
                ),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }
}

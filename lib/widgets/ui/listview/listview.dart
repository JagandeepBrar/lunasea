import 'package:flutter/material.dart';

class LSListView extends StatelessWidget {
    final List<Widget> children;
    final bool padBottom;
    final EdgeInsetsGeometry customPadding;

    LSListView({
        @required this.children,
        this.padBottom = false,
        this.customPadding = const EdgeInsets.symmetric(vertical: 8.0),
    });

    @override
    Widget build(BuildContext context) {
        return Scrollbar(
            child: ListView(
                children: children,
                padding: padBottom
                    ? EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 20.0)
                    : customPadding,
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }
}

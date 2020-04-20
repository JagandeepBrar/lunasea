import 'package:flutter/material.dart';

class LSListView extends StatelessWidget {
    final List<Widget> children;
    final bool padBottom;
    final EdgeInsetsGeometry customPadding;
    final ScrollController controller;

    LSListView({
        @required this.children,
        this.padBottom = false,
        this.controller,
        this.customPadding = const EdgeInsets.symmetric(vertical: 8.0),
    });

    @override
    Widget build(BuildContext context) => Scrollbar(
        controller: controller,
        child: ListView(
            controller: controller,
            children: children,
            padding: padBottom
                ? EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 20.0)
                : customPadding,
            physics: AlwaysScrollableScrollPhysics(),
        ),
    );
}

import 'package:flutter/material.dart';

class LSListView extends StatelessWidget {
    final List<Widget> children;
    final EdgeInsetsGeometry customPadding;
    final ScrollController controller;

    LSListView({
        @required this.children,
        this.controller,
        this.customPadding,
    });

    @override
    Widget build(BuildContext context) => Scrollbar(
        controller: controller == null ? ScrollController() : controller,
        child: ListView(
            controller: controller,
            children: children,
            padding: customPadding != null ? customPadding : EdgeInsets.only(
                top: 8.0,
                bottom: 8.0+(MediaQuery.of(context).padding.bottom/5),
            ),
            physics: AlwaysScrollableScrollPhysics(),
        ),
    );
}

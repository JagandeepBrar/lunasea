import 'package:flutter/material.dart';

class LSListViewBuilder extends StatelessWidget {
    final int itemCount;
    final Function(BuildContext context, int index) itemBuilder;
    final bool padBottom;
    final EdgeInsetsGeometry customPadding;

    LSListViewBuilder({
        @required this.itemCount,
        @required this.itemBuilder,
        this.padBottom = false,
        this.customPadding = const EdgeInsets.symmetric(vertical: 8.0),
    });

    @override
    Widget build(BuildContext context) => Scrollbar(
        child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            padding: padBottom
                ? EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 20.0)
                : customPadding,
            physics: AlwaysScrollableScrollPhysics(),
        ),
    );
}
import 'package:flutter/material.dart';

class LSListViewBuilder extends StatelessWidget {
    final int itemCount;
    final bool reverse;
    final Function(BuildContext context, int index) itemBuilder;
    final EdgeInsetsGeometry customPadding;
    final ScrollController controller = ScrollController();

    LSListViewBuilder({
        @required this.itemCount,
        @required this.itemBuilder,
        this.reverse = false,
        this.customPadding,
    });

    @override
    Widget build(BuildContext context) => Scrollbar(
        controller: controller,
        child: ListView.builder(
            controller: controller,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            padding: customPadding != null ? customPadding : EdgeInsets.only(
                top: 8.0,
                bottom: 8.0+(MediaQuery.of(context).padding.bottom),
            ),
            reverse: reverse,
            physics: AlwaysScrollableScrollPhysics(),
        ),
    );
}
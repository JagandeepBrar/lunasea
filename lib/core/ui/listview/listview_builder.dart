import 'package:flutter/material.dart';

class LSListViewBuilder extends StatelessWidget {
    final int itemCount;
    final Function(BuildContext context, int index) itemBuilder;
    final EdgeInsetsGeometry customPadding;
    final ScrollController controller = ScrollController();

    LSListViewBuilder({
        @required this.itemCount,
        @required this.itemBuilder,
        this.customPadding = const EdgeInsets.symmetric(vertical: 8.0),
    });

    @override
    Widget build(BuildContext context) => Scrollbar(
        controller: controller,
        child: ListView.builder(
            controller: controller,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            padding: customPadding,
            physics: AlwaysScrollableScrollPhysics(),
        ),
    );
}
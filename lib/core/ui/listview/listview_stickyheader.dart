import 'package:flutter/material.dart';

class LSListViewStickyHeader extends StatelessWidget {
    final List<Widget> slivers;
    final ScrollController controller;
    final EdgeInsets padding;

    LSListViewStickyHeader({
        @required this.slivers,
        @required this.controller,
        this.padding = EdgeInsets.zero,
    });

    @override
    Widget build(BuildContext context) => Scrollbar(
        controller: controller,
        child: Container(
            child: CustomScrollView(
                controller: controller,
                slivers: [
                    ...slivers,
                ],
                physics: AlwaysScrollableScrollPhysics(),
            ),
            padding: padding,
        ),
    );
}

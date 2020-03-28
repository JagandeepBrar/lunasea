import 'package:flutter/material.dart';

class LSListViewStickyHeader extends StatelessWidget {
    final List<Widget> slivers;
    final double customInnerBottomPadding;
    final ScrollController controller;
    final EdgeInsets padding;

    LSListViewStickyHeader({
        @required this.slivers,
        this.customInnerBottomPadding = 2.0,
        this.controller,
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
                    SliverFillRemaining(
                        child: Container(height: customInnerBottomPadding),
                        hasScrollBody: false,
                    ),
                ],
                physics: AlwaysScrollableScrollPhysics(),
            ),
            padding: padding,
        ),
    );
}

import 'package:flutter/material.dart';

class LSListViewStickyHeader extends StatelessWidget {
    final List<Widget> slivers;
    final double customInnerBottomPadding;
    final bool topPadding;
    final ScrollController controller;

    LSListViewStickyHeader({
        @required this.slivers,
        this.customInnerBottomPadding = 2.0,
        this.topPadding = false,
        this.controller,
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
            padding: topPadding
                ? EdgeInsets.only(top: 14.0)
                : EdgeInsets.zero,
        ),
    );
}

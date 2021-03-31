import 'package:flutter/material.dart';

class LunaReorderableListViewBuilder extends StatelessWidget {
    final int itemCount;
    final Widget Function(BuildContext, int) itemBuilder;
    final EdgeInsetsGeometry padding;
    final ScrollPhysics physics;
    final ScrollController controller;
    final void Function(int, int) onReorder;

    LunaReorderableListViewBuilder({
        Key key,
        @required this.itemCount,
        @required this.itemBuilder,
        @required this.controller,
        @required this.onReorder,
        this.padding,
        this.physics = const AlwaysScrollableScrollPhysics(),
    }) : super(key: key) {
        assert(itemCount != null);
        assert(itemBuilder != null);
    }

    @override
    Widget build(BuildContext context) {
        return Scrollbar(
            controller: controller,
            child: ReorderableListView.builder(
                scrollController: controller,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: padding ?? MediaQuery.of(context).padding.add(EdgeInsets.symmetric(vertical: 8.0)),
                physics: physics,
                itemCount: itemCount,
                itemBuilder: itemBuilder,
                onReorder: onReorder,
            ),
        );
    }
}

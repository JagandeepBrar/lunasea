import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaListViewBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final double itemExtent;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final ScrollController controller;

  LunaListViewBuilder({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    this.itemExtent,
    @required this.controller,
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
      child: ListView.builder(
        controller: controller,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: padding ??
            MediaQuery.of(context).padding.add(EdgeInsets.symmetric(
                  vertical: LunaUI.MARGIN_H_DEFAULT_V_HALF.bottom,
                )),
        physics: physics,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        itemExtent: itemExtent,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaListView extends StatelessWidget {
  final List<Widget> children;
  final double? itemExtent;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics physics;
  final ScrollController? controller;

  const LunaListView({
    Key? key,
    required this.children,
    required this.controller,
    this.itemExtent,
    this.padding,
    this.physics = const AlwaysScrollableScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      interactive: true,
      child: ListView(
        controller: controller,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: children,
        itemExtent: itemExtent,
        padding: padding ??
            MediaQuery.of(context).padding.add(EdgeInsets.symmetric(
                  vertical: LunaUI.MARGIN_H_DEFAULT_V_HALF.bottom,
                )),
        physics: physics,
      ),
    );
  }
}

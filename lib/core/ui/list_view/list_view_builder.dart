import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaListViewBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final double? itemExtent;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics physics;
  final ScrollController controller;

  const LunaListViewBuilder({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemExtent,
    required this.controller,
    this.padding,
    this.physics = const AlwaysScrollableScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      interactive: true,
      child: ListView.builder(
        controller: controller,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: padding ?? _defaultPadding(context),
        physics: physics,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        itemExtent: itemExtent,
      ),
    );
  }

  EdgeInsets _defaultPadding(BuildContext context) {
    return MediaQuery.of(context).padding.add(LunaUI.MARGIN_HALF_VERTICAL)
        as EdgeInsets;
  }
}

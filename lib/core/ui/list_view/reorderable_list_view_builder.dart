import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import './flutter_reorderable_list_view.dart';

class LunaReorderableListViewBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final ScrollController controller;
  final void Function(int, int) onReorder;
  final bool buildDefaultDragHandles;

  LunaReorderableListViewBuilder({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.controller,
    @required this.onReorder,
    this.padding,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.buildDefaultDragHandles = false,
  }) : super(key: key) {
    assert(itemCount != null);
    assert(itemBuilder != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      child: FlutterReorderableListView.builder(
        scrollController: controller,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: padding ??
            MediaQuery.of(context).padding.add(EdgeInsets.symmetric(
                  vertical: LunaUI.MARGIN_H_DEFAULT_V_HALF.bottom,
                )),
        physics: physics,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        onReorder: onReorder,
        buildDefaultDragHandles: buildDefaultDragHandles,
      ),
    );
  }
}

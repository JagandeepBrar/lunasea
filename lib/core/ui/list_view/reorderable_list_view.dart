import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import './flutter_reorderable_list_view.dart';

class LunaReorderableListView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final ScrollController controller;
  final void Function(int, int) onReorder;
  final bool buildDefaultDragHandles;

  const LunaReorderableListView({
    Key key,
    @required this.children,
    @required this.controller,
    @required this.onReorder,
    this.padding,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.buildDefaultDragHandles = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      child: FlutterReorderableListView(
        scrollController: controller,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: children,
        padding: padding ??
            MediaQuery.of(context).padding.add(EdgeInsets.symmetric(
                  vertical: LunaUI.MARGIN_H_DEFAULT_V_HALF.bottom,
                )),
        physics: physics,
        onReorder: onReorder,
        buildDefaultDragHandles: buildDefaultDragHandles,
      ),
    );
  }
}

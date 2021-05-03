import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// [ListView] builder with a [Scrollbar] that is intended to be used with a modal bottom sheet.
///
/// The [ScrollController] is pulled from the context from the sheet, and cannot be defined.
///
/// By default, the list is shrink-wrapped.
class LunaListViewModalBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final double itemExtent;
  final bool shrinkWrap;

  LunaListViewModalBuilder({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    this.itemExtent,
    this.shrinkWrap = true,
  }) : super(key: key) {
    assert(itemCount != null);
    assert(itemBuilder != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: ModalScrollController.of(context),
      child: ListView.builder(
        controller: ModalScrollController.of(context),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: MediaQuery.of(context).padding.add(EdgeInsets.symmetric(
              vertical: LunaUI.MARGIN_CARD.bottom,
            )),
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        itemExtent: itemExtent,
        shrinkWrap: shrinkWrap,
      ),
    );
  }
}
